import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist.dart';
import 'package:yt_playlists_plus/model/enums/playlist_status.dart';
import 'package:yt_playlists_plus/controller/export_import_controller.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/services/popup_service/show_snackbar.dart';
import 'package:yt_playlists_plus/services/fetching_service.dart';
import 'package:yt_playlists_plus/controller/video_controller.dart';
import 'package:yt_playlists_plus/model/video_history.dart';
import 'package:yt_playlists_plus/model/enums/video_status.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';

class PlaylistController extends ChangeNotifier {
  final Playlist playlist;
  int? length; //? only used during download

  String get id => playlist.id;
  String get title => playlist.title;
  set title(String value) {
    playlist.title = value;
    notifyListeners();
  }

  String get author => playlist.author;
  set author(String value) {
    playlist.author = value;
    notifyListeners();
  }

  String get thumbnailUrl => playlist.thumbnailUrl;
  set thumbnailUrl(String value) {
    playlist.thumbnailUrl = value;
    notifyListeners();
  }

  ///Local data
  Set<VideoController> get videos =>
      playlist.videos.map((e) => VideoController(video: e)).toSet();
  set videos(Set<VideoController> value) {
    playlist.videos = value.map((e) => e.video).toSet();
    notifyListeners();
  }

  ///Data from youtube
  final Set<VideoController> _fetch = {};
  bool _fetching = false;

  ///Set of planned titles
  Set<String> get planned => playlist.planned;

  ///The playlist's `current` status
  PlaylistStatus get status => _status;
  PlaylistStatus _status = PlaylistStatus.unChecked;

  ///Changes status & alerts listeners
  setStatus(PlaylistStatus newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  ///Previously deleted and added videos
  List<VideoHistory> get history => playlist.history;

  //? history since the last Unchanged State of the playlist
  //? used for comparing recent histories, to not flood the
  //? main history List with the same data
  final Set<VideoHistory> _recentHistory = {};

  //? used to keep changes until they're finalized
  final Set<VideoController> _added = {};
  final Set<VideoController> _missing = {};

  ///Whether the playlist has been changed
  ///
  ///0 if not changed, otherwise shows the number of changes
  int get modified => _modified;
  int _modified = 0;

  ///Shows the fetching progress
  ///
  ///Not exact, but the bigger the list the more accurate it is
  int progress = 0;

  ///Sets new progress and notifies listeners
  void setProgress(double newProgress) {
    progress = _setProgress(progress, newProgress);
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

  PlaylistController({
    required this.playlist,
    this.length,
  });

  //#region [videos], [fetch], [history]

  ///Adds a video to the Set of [videos]
  ///
  ///returns `true` if successful
  bool addToVideos(VideoController video) => videos.add(video);

  ///Removes a video from the Set of [videos]
  ///
  ///returns `true` if successful
  bool removeFromVideos(VideoController video) => videos.remove(video);

  ///Returns the difference of the `local` videos and the `fetched` videos
  ///
  ///Video's function is set to `remove`
  Set<VideoController> getMissing() {
    //? do nothing, if empty or fetching (otherwise false data)
    if (_fetching || _fetch.isEmpty) return {};

    final Set<VideoController> clonedVideos =
        videos.map((e) => VideoController.deepCopy(e)).toSet();
    final Set<VideoController> clonedMissing = clonedVideos.difference(_fetch);

    for (final VideoController video in clonedMissing) {
      video.setStatus(VideoStatus.missing);

      //? onTap
      video.onTap = () {
        if (video.status == VideoStatus.missing) {
          video.setStatus(VideoStatus.pending);
          videos.remove(video);
          _modified++;
        } else if (video.status == VideoStatus.pending) {
          video.setStatus(VideoStatus.missing);
          videos.add(video);
          _modified--;
        }
        notifyListeners();
      };

      //? statusFunction
      video.statusFunction = (BuildContext context) {
        bool added = planned.add(video.title);
        PopUpService().showSnackBar(
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
  Set<VideoController> getAdded() {
    if (_fetching || _fetch.isEmpty) return {};

    final Set<VideoController> clonedFetch =
        _fetch.map((e) => VideoController.deepCopy(e)).toSet();
    final Set<VideoController> clonedAdded = clonedFetch.difference(videos);

    //? cleanup previus fetch
    _added.removeWhere((video) => !_fetch.contains(video));

    for (final VideoController video in clonedAdded) {
      video.setStatus(VideoStatus.added);

      //? onTap
      video.onTap = () {
        if (video.status == VideoStatus.added) {
          video.setStatus(VideoStatus.pending);
          videos.add(video);
          _modified++;
        } else if (video.status == VideoStatus.pending) {
          video.setStatus(VideoStatus.added);
          videos.remove(video);
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
    ExportImportController().disable();
    setStatus(PlaylistStatus.downloading);
    setProgress(0);
    _isNetworkingCancelled = false;

    bool first = true;
    try {
      await for (final VideoController video
          in FetchingService.getVideosFromPlaylist(id)) {
        if (_isNetworkingCancelled) {
          return;
        }
        videos.add(video);
        setProgress(videos.length / (length ?? 1));
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
    ExportImportController().tryEnable();
  }

  ///Fetches the videos of the playlist and adds them to its [_fetch] Set
  Future<void> fetchVideos() async {
    if (_status == PlaylistStatus.fetching ||
        _status == PlaylistStatus.downloading) return;

    //?? cleanup
    _fetching = true;
    _fetch.clear();
    setStatus(PlaylistStatus.fetching);
    setProgress(0);
    _isNetworkingCancelled = false;

    try {
      await for (final VideoController video
          in FetchingService.getVideosFromPlaylist(id)) {
        if (_isNetworkingCancelled) {
          return;
        }
        _fetch.add(video);
        setProgress(_fetch.length / videos.length);
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

    if (_fetch.isEmpty && !(await FetchingService.existsPlaylist(id))) {
      setStatus(PlaylistStatus.notFound);
      return;
    }

    getAdded().isEmpty && getMissing().isEmpty
        ? setStatus(PlaylistStatus.unChanged)
        : setStatus(PlaylistStatus.changed);

    if (status == PlaylistStatus.changed) {
      for (final VideoController video in getAdded()) {
        final VideoHistory addedHistory = VideoHistory.fromVideo(
          video: video,
          status: VideoStatus.added,
        );

        if (history.lastOrNull != addedHistory &&
            !_recentHistory.contains(addedHistory)) {
          history.add(addedHistory);
          _recentHistory.add(addedHistory);
        }
      }

      for (final VideoController video in getMissing()) {
        final VideoHistory missingHistory = VideoHistory.fromVideo(
          video: video,
          status: VideoStatus.missing,
        );

        if (history.lastOrNull != missingHistory &&
            !_recentHistory.contains(missingHistory)) {
          history.add(missingHistory);
          _recentHistory.add(missingHistory);
        }
      }
    } else if (status == PlaylistStatus.unChanged) {
      videos = _fetch.map((e) => VideoController.deepCopy(e)).toSet();
      _recentHistory.clear();
      PlaylistsService().save();
    }
  }

  //#endregion

  //#region @overrides

  @override
  String toString() => "\nPlaylist(title: $title, author: $author)";

  ///returns the `Set` of [videos] with the playlist
  String toExtendedString() =>
      "\nPlaylist(title: $title, author: $author, videos: [${videos.toString()}])";

  @override
  bool operator ==(other) => other is PlaylistController && id == other.id;

  @override
  int get hashCode => Object.hash(id, null);

  //#endregion

  //#region json

  ///Converts a `json` Object into a `Playlist` Object
  PlaylistController.fromJson(Map<String, dynamic> json)
      : playlist = Playlist.fromJson(json);

  ///Converts a `Playlist` Object into a `json` Object
  Map<String, dynamic> toJson() => playlist.toJson();

  //#endregion
}
