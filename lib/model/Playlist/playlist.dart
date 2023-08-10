import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_exception.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/model/client.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';

class Playlist extends ChangeNotifier {
  String id, title, author, thumbnailUrl;

  //? local data
  Set<Video> _videos = {};
  Set<Video> get videos => _videos;

  //? data from youtube
  final Set<Video> _fetch = {};
  bool _fetching = false;

  //? planned titles
  Set<String> _planned = {};
  Set<String> get planned => _planned;

  //? what the playlist's current state is
  PlaylistStatus _status = PlaylistStatus.unChecked;
  PlaylistStatus get status => _status;

  //? previously deleted and added videos
  List<VideoHistory> _history = [];
  List<VideoHistory> get history => _history;

  //? history since the last Unchanged State of the playlist
  //? used for comparing recent histories, to not flood the
  //? main histtory List with the same data
  final Set<VideoHistory> _recentHistory = {};

  //?used to keep changes until they're finalized
  final Set<Video> _added = {};
  final Set<Video> _missing = {};

  ///Sets the state and notifies listeners
  setStatus(PlaylistStatus newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  Playlist({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
  });

  //#region [videos], [fetch]

  ///Adds a video to the Set of [_videos]
  ///
  ///returns `true` if successful
  bool addToVideos(Video video) => _videos.add(video);

  ///Removes a video from the Set of [_videos]
  ///
  ///returns `true` if successful
  bool removeFromVideos(Video video) => _videos.remove(video);

  ///Returns the difference of the `local` videos and the `fetched` videos
  ///
  ///Video's function is set to `remove`
  Set<Video> getMissing() {
    if (_fetching || _fetch.isEmpty) return {};
    Set<Video> clonedVideos = _videos.map((e) => Video.deepCopy(e)).toSet();
    Set<Video> missing = clonedVideos.difference(_fetch);

    for (var video in missing) {
      video.setStatus(VideoStatus.missing);
      video.function = () {
        if (video.status == VideoStatus.missing) {
          video.setStatus(VideoStatus.pending);
          _videos.remove(video);
        } else if (video.status == VideoStatus.pending) {
          video.setStatus(VideoStatus.missing);
          _videos.add(video);
        }
      };
    }
    _missing.addAll(missing);
    return _missing;
  }

  ///Returns the difference of the `fetched` videos and the `local` videos
  ///
  ///Video's function is set to `add`
  Set<Video> getAdded() {
    Set<Video> clonedFetch = _fetch.map((e) => Video.deepCopy(e)).toSet();
    Set<Video> added = clonedFetch.difference(_videos);

    _added.removeWhere((video) => !_fetch.contains(video));

    for (var video in added) {
      video.setStatus(VideoStatus.added);
      video.function = () {
        if (video.status == VideoStatus.added) {
          video.setStatus(VideoStatus.pending);
          _videos.add(video);
        } else if (video.status == VideoStatus.pending) {
          video.setStatus(VideoStatus.added);
          _videos.remove(video);
        }
      };
    }
    _added.addAll(added);
    return _added;
  }

  ///Used after saving
  void clearPending() {
    _added.removeWhere((video) => video.status == VideoStatus.pending);
    _missing.removeWhere((video) => video.status == VideoStatus.pending);
    notifyListeners();
  }

  ///Compares the playlist's persistent and fetched data,
  ///and changes the state accordingly
  ///
  ///After check, [history] will be updated
  ///
  ///Throws `PlaylistException` if the state isn't `fetching`
  void check() async {
    if (_status != PlaylistStatus.fetching) {
      throw PlaylistException("PlaylistState != fetching when starting check.");
    }
    setStatus(PlaylistStatus.checking);

    thumbnailUrl = _fetch.firstOrNull?.thumbnailUrl ?? "";

    if ((thumbnailUrl == "") && !(await YoutubeClient().existsPlaylist(id))) {
      setStatus(PlaylistStatus.notFound);
      return;
    }

    getAdded().isEmpty && getMissing().isEmpty
        ? setStatus(PlaylistStatus.unChanged)
        : setStatus(PlaylistStatus.changed);

    if (status == PlaylistStatus.changed) {
      for (var video in getAdded()) {
        VideoHistory videoHistory = VideoHistory.fromVideo(
          video: video,
          status: VideoStatus.added,
        );

        if (_history.lastOrNull != videoHistory &&
            !_recentHistory.contains(videoHistory)) {
          _history.add(videoHistory);
          _recentHistory.add(videoHistory);
        }
      }

      for (var video in getMissing()) {
        var videoHistory = VideoHistory.fromVideo(
          video: video,
          status: VideoStatus.missing,
        );

        if (_history.lastOrNull != videoHistory &&
            !_recentHistory.contains(videoHistory)) {
          _history.add(videoHistory);
          _recentHistory.add(videoHistory);
        }
      }
    } else if (status == PlaylistStatus.unChanged) {
      _videos = _fetch.map((e) => Video.deepCopy(e)).toSet();
      _recentHistory.clear();
    }
  }

  ///Fetches the videos of the playlist and adds them to its `fetch` Set
  Stream<Video> fetchVideos() async* {
    if (_status == PlaylistStatus.fetching) return;

    _fetching = true;
    _fetch.clear();
    setStatus(PlaylistStatus.fetching);

    YoutubeClient client = YoutubeClient();
    try {
      await for (Video video in client.getVideosFromPlaylist(id)) {
        _fetch.add(video);
        yield video;
      }
    } on SocketException catch (_) {
      setStatus(PlaylistStatus.unChecked);
      rethrow;
    } finally {
      _fetching = false;
    }
  }

  ///Fetches the videos of the playlist and adds them to its `videos` Set
  Future<void> download() async {
    if (status != PlaylistStatus.notDownloaded) return;
    setStatus(PlaylistStatus.downloading);

    YoutubeClient client = YoutubeClient();
    await for (Video video in client.getVideosFromPlaylist(id)) {
      _videos.add(video);
    }

    setStatus(PlaylistStatus.downloaded);
  }

  //#endregion

  //#region [planned]

  ///Adds a `String` to the [_planned] Set
  ///
  ///Returns the success
  bool addTitleToPlanned(String title) => _planned.add(title);

  ///Removes a `String` from the [_planned] Set
  ///
  ///Returns the success
  bool removeTitleFromPlanned(String title) => _planned.remove(title);

  ///Adds a `Video`'s title to the [_planned] Set
  ///
  ///Returns the success
  bool addVideoToPlanned(Video video) => _planned.add(video.title);

  ///Removes a `Video`'s title from the [_planned] Set
  ///
  ///Returns the success
  bool removeVideoFromPlanned(Video video) => _planned.remove(video.title);

  //#endregion

  //#region @overrides

  @override
  String toString() => "\nPlaylist(title: $title, author: $author)";

  ///returns the `Set` of [_videos] with the playlist
  String toExtendedString() =>
      "\nPlaylist(title: $title, author: $author, videos: [${_videos.toString()}])";

  @override
  bool operator ==(other) => other is Playlist && id == other.id;

  @override
  int get hashCode => Object.hash(id, null);

  //#endregion

  //#region json

  ///Converts a `json` Object into a `Playlist` Object
  Playlist.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        author = json['author'],
        thumbnailUrl = json['thumbnailUrl'],
        _videos = (json['videos'] as List)
            .map((video) => Video.fromJson(video))
            .toSet(),
        _planned = Set.from(
            (jsonDecode(json['planned']) as List<dynamic>).cast<String>()),
        _history = (json['history'] as List)
            .map((videoHistory) => VideoHistory.fromJson(videoHistory))
            .toList();

  ///Converts a `Playlist` Object into a `json` Object
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'thumbnailUrl': thumbnailUrl,
        'videos': _videos.map((video) => video.toJson()).toList(),
        'planned': jsonEncode(_planned.toList()),
        'history':
            _history.map((videoHistory) => videoHistory.toJson()).toList()
      };

  //#endregion
}
