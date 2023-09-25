import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_exception.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/services/youtube_data_service.dart';
import 'package:yt_playlists_plus/services/popup_service.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:yt_playlists_plus/persistence.dart';
import 'package:yt_playlists_plus/services/playlists_service.dart';
import 'package:yt_playlists_plus/services/settings_service/history_limit_service.dart';

class Playlist extends ChangeNotifier {
  final String id;
  String title, author, thumbnailUrl;
  int? length; //? only used during download

  ///Local data
  Set<Video> get videos => _videos;
  Set<Video> _videos = {};

  ///Data from youtube
  final Set<Video> _fetch = {};
  bool _fetching = false;

  ///Set of planned titles
  Set<String> get planned => _planned;
  Set<String> _planned = {};

  ///The playlist's `current` status
  PlaylistStatus get status => _status;
  PlaylistStatus _status = PlaylistStatus.unChecked;

  ///Changes status & alerts listeners
  setStatus(PlaylistStatus newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  ///Previously deleted and added videos
  List<VideoHistory> get history => _history;
  List<VideoHistory> _history = [];

  //? history since the last Unchanged State of the playlist
  //? used for comparing recent histories, to not flood the
  //? main history List with the same data
  final Set<VideoHistory> _recentHistory = {};

  //? used to keep changes until they're finalized
  final Set<Video> _added = {};
  final Set<Video> _missing = {};

  ///Whether the playlist has been changed
  ///
  ///0 if not changed, otherwise shows the number of changes
  int get modified => _modified;
  int _modified = 0;

  ///Shows the fetching progress
  ///
  ///Not exact, but the bigger the list the more accurate it is
  int fetchProgress = 0;

  ///Sets new progress and notifies listeners
  void setFetchProgress(double newProgress) {
    fetchProgress = _setProgress(fetchProgress, newProgress);
    notifyListeners();
  }

  ///Shows the download progress
  int downloadProgress = 0;

  ///Sets the download progress
  void setDownloadProgress(double newProgress) {
    downloadProgress = _setProgress(downloadProgress, newProgress);
    notifyListeners();
  }

  int _setProgress(int toSet, double newProgress) {
    const int steps = 40;

    final int returnProgress =
        (newProgress * steps).round() * (100 / steps).round();
    if (toSet != returnProgress) {
      return returnProgress <= 100 ? returnProgress : 100;
    }
    return toSet;
  }

  bool _isNetworkingCancelled = false;

  ///Cancels download or fetching, if it is in progress
  void cancelNetworking() => _isNetworkingCancelled = true;

  Playlist({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
    this.length,
  });

  //#region [videos], [fetch], [history]

  ///Adds a video to the Set of [videos]
  ///
  ///returns `true` if successful
  bool addToVideos(Video video) => _videos.add(video);

  ///Removes a video from the Set of [videos]
  ///
  ///returns `true` if successful
  bool removeFromVideos(Video video) => _videos.remove(video);

  ///Returns the difference of the `local` videos and the `fetched` videos
  ///
  ///Video's function is set to `remove`
  Set<Video> getMissing() {
    //? do nothing, if empty or fetching (otherwise false data)
    if (_fetching || _fetch.isEmpty) return {};

    final Set<Video> clonedVideos =
        _videos.map((e) => Video.deepCopy(e)).toSet();
    final Set<Video> clonedMissing = clonedVideos.difference(_fetch);

    for (final Video video in clonedMissing) {
      video.setStatus(VideoStatus.missing);

      //? onTap
      video.onTap = () {
        if (video.status == VideoStatus.missing) {
          video.setStatus(VideoStatus.pending);
          _videos.remove(video);
          _modified++;
        } else if (video.status == VideoStatus.pending) {
          video.setStatus(VideoStatus.missing);
          _videos.add(video);
          _modified--;
        }
        notifyListeners();
      };

      //? statusFunction
      video.statusFunction = (BuildContext context) {
        bool added = planned.add(video.title);
        PopUpService.showSnackBar(
            context: context,
            message:
                added ? "Video added to Planned" : "Video already in Planned");
      };
    }

    _missing.addAll(clonedMissing);
    return _missing;
  }

  ///Returns the difference of the `fetched` videos and the `local` videos
  ///
  ///Video's function is set to `add`
  Set<Video> getAdded() {
    if (_fetching || _fetch.isEmpty) return {};

    final Set<Video> clonedFetch = _fetch.map((e) => Video.deepCopy(e)).toSet();
    final Set<Video> clonedAdded = clonedFetch.difference(_videos);

    //? cleanup previus fetch
    _added.removeWhere((video) => !_fetch.contains(video));

    for (final Video video in clonedAdded) {
      video.setStatus(VideoStatus.added);

      //? onTap
      video.onTap = () {
        if (video.status == VideoStatus.added) {
          video.setStatus(VideoStatus.pending);
          _videos.add(video);
          _modified++;
        } else if (video.status == VideoStatus.pending) {
          video.setStatus(VideoStatus.added);
          _videos.remove(video);
          _modified--;
        }
        notifyListeners();
      };

      //? statusFunction
      video.statusFunction = (BuildContext context) => null;
    }

    _added.addAll(clonedAdded);
    return _added;
  }

  ///Clears all videos from [_added] & [_missing] that are in `Pending` status
  ///
  ///Notifies listeners after
  void clearPending() {
    _added.removeWhere((video) => video.status == VideoStatus.pending);
    _missing.removeWhere((video) => video.status == VideoStatus.pending);
    _modified = 0;
    notifyListeners();
  }

  ///Fetches the videos of the playlist and adds them to its [videos] Set
  Future<void> download() async {
    if (status != PlaylistStatus.notDownloaded) return;
    Persistence.disableExportImport();
    setStatus(PlaylistStatus.downloading);
    setDownloadProgress(0);
    _isNetworkingCancelled = false;

    bool first = true;
    try {
      YoutubeDataService();
      await for (final Video video
          in YoutubeDataService.getVideosFromPlaylist(id)) {
        if (_isNetworkingCancelled) {
          return;
        }
        _videos.add(video);
        setDownloadProgress(_videos.length / (length ?? 1));
        if (first) {
          thumbnailUrl = video.thumbnailUrl;
          notifyListeners();
          first = false;
        }
        //? if it started, add Playlist
        PlaylistsService().add(this);
      }
    } on SocketException {
      //? if it fails anytime, remove Playlist
      PlaylistsService().remove(this);
      setStatus(PlaylistStatus.notDownloaded);
      rethrow;
    }

    setStatus(PlaylistStatus.downloaded);
    Persistence().tryEnableExportImport();
  }

  ///Fetches the videos of the playlist and adds them to its [_fetch] Set
  Future<void> fetchVideos() async {
    if (_status == PlaylistStatus.fetching ||
        _status == PlaylistStatus.downloading) return;

    //? cleanup
    _fetching = true;
    _fetch.clear();
    setStatus(PlaylistStatus.fetching);
    setFetchProgress(0);
    _isNetworkingCancelled = false;

    try {
      YoutubeDataService();
      await for (final Video video
          in YoutubeDataService.getVideosFromPlaylist(id)) {
        if (_isNetworkingCancelled) {
          return;
        }
        _fetch.add(video);
        setFetchProgress(_fetch.length / _videos.length);
      }
    } on SocketException {
      setStatus(PlaylistStatus.unChecked);
      rethrow;
    } finally {
      _fetching = false;
    }
  }

  ///Compares the playlist's persistent and fetched data,
  ///and changes the state accordingly
  ///
  ///After check, [history] will be updated
  ///
  ///Throws `PlaylistException` if the state isn't `fetching`
  Future<void> check() async {
    if (_status != PlaylistStatus.fetching) {
      throw PlaylistException("PlaylistState != fetching when starting check.");
    }

    setStatus(PlaylistStatus.checking);

    //? update thumbnail if different
    final String newthumbnailUrl =
        _fetch.firstOrNull?.thumbnailUrl ?? thumbnailUrl;
    if (newthumbnailUrl != thumbnailUrl) {
      thumbnailUrl = newthumbnailUrl;
    }

    if (_fetch.isEmpty && !(await YoutubeDataService.existsPlaylist(id))) {
      setStatus(PlaylistStatus.notFound);
      return;
    }

    getAdded().isEmpty && getMissing().isEmpty
        ? setStatus(PlaylistStatus.unChanged)
        : setStatus(PlaylistStatus.changed);

    if (status == PlaylistStatus.changed) {
      for (final Video video in getAdded()) {
        final VideoHistory addedHistory = VideoHistory.fromVideo(
          video: video,
          status: VideoStatus.added,
        );

        if (_history.lastOrNull != addedHistory &&
            !_recentHistory.contains(addedHistory)) {
          _history.add(addedHistory);
          _recentHistory.add(addedHistory);
        }
      }

      for (final Video video in getMissing()) {
        final VideoHistory missingHistory = VideoHistory.fromVideo(
          video: video,
          status: VideoStatus.missing,
        );

        if (_history.lastOrNull != missingHistory &&
            !_recentHistory.contains(missingHistory)) {
          _history.add(missingHistory);
          _recentHistory.add(missingHistory);
        }
      }
    } else if (status == PlaylistStatus.unChanged) {
      _videos = _fetch.map((e) => Video.deepCopy(e)).toSet();
      _recentHistory.clear();
      PlaylistsService().save();
    }
  }

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
  Map<String, dynamic> toJson() {
    int historyLimit = HistoryLimitService().limit ?? _history.length;
    return {
      'id': id,
      'title': title,
      'author': author,
      'thumbnailUrl': thumbnailUrl,
      'videos': _videos.map((video) => video.toJson()).toList(),
      'planned': jsonEncode(_planned.toList()),
      'history': _history.reversed
          .take(historyLimit)
          .toList()
          .reversed
          .map((videoHistory) => videoHistory.toJson())
          .toList()
    };
  }

  //#endregion
}
