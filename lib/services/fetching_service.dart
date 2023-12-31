import 'dart:async';
import 'dart:io';
import 'package:synchronized/synchronized.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt_explode;
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/model/playlist.dart';
import 'package:yt_playlists_plus/controller/video_controller.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';
import 'package:yt_playlists_plus/model/video.dart';

///Youtube playlist fetching service
///
///Wrapper for the `YoutubeExplode` client
class FetchingService {
  static yt_explode.YoutubeExplode? _client;

  //?? sync lock
  static final Lock _lock = Lock();

  static int _fetchCount = 0;
  static void _addFetch() => _lock.synchronized(() => _fetchCount++);
  static void _removeFetch() => _lock.synchronized(() => _fetchCount--);

  static void _tryCloseCient() {
    if (_fetchCount == 0) {
      _client!.close();
      _client = null;
    }
  }

  ///Searches Youtube playlists with a given `query`
  ///
  ///Yields results
  static Stream<PlaylistController> searchByQuery({
    required String query,
    List<String>? excludedWords,
  }) async* {
    query += " "; //hack: it gives better results

    if (excludedWords != null) {
      for (final String word in excludedWords) {
        query += "-$word ";
      }
    }

    _client ??= yt_explode.YoutubeExplode();
    _addFetch();

    try {
      final yt_explode.SearchList<yt_explode.BaseSearchContent> result =
          await _client!.search
              .searchContent(query, filter: yt_explode.TypeFilters.playlist);
      for (final yt_explode.BaseSearchContent list in result) {
        yield await _getPlaylist(
            (list as yt_explode.SearchPlaylist).playlistId.toString());
      }
    } on SocketException {
      rethrow;
    } on PlaylistException {
      return;
    } finally {
      _removeFetch();
      _tryCloseCient();
    }
  }

  ///Returns a single Playlist from the given `url`
  ///
  ///Returns null if the url is invalid or the Playlist ID doesn't exist
  static Future<PlaylistController?> searchByLink({required String url}) async {
    final String? id = yt_explode.PlaylistId.parsePlaylistId(url);

    //if id couldn't be parsed
    if (id == null) {
      return null;
    }

    //if already contains
    if (PlaylistsController()
        .playlists
        .any((final PlaylistController pl) => pl.id == id)) {
      return null;
    }
    _client ??= yt_explode.YoutubeExplode();
    _addFetch();

    try {
      return await _getPlaylist(id);
    } on SocketException {
      rethrow;
    } on PlaylistException {
      return null;
    } finally {
      _removeFetch();
      _tryCloseCient();
    }
  }

  static Future<bool> existsPlaylist(String playlistId) async {
    _client ??= yt_explode.YoutubeExplode();
    _addFetch();

    try {
      final yt_explode.Playlist result =
          await _client!.playlists.get(playlistId);
      return result.title != "";
    } on Exception {
      return false;
    } finally {
      _removeFetch();
      _tryCloseCient();
    }
  }

  static Future<Playlist> fetchPlaylist(String playlistId) async =>
      (await _getPlaylist(playlistId)).playlist;

  //?? gets playlist information
  static Future<PlaylistController> _getPlaylist(String playlistId) async {
    _client ??= yt_explode.YoutubeExplode();
    _addFetch();

    try {
      final yt_explode.Playlist result =
          await _client!.playlists.get(playlistId);

      if (result.title == "") {
        throw PlaylistException("Playlist doesn't exist with id $playlistId");
      }

      String author = result.author;
      if (!result.author.startsWith("by")) author = "by ${result.author}";

      return PlaylistController(
        playlist: Playlist(
          id: result.id.toString(),
          title: result.title,
          author: author,
          description: result.description,
          thumbnailUrl: "", //?? at download
        ),
        length: result.videoCount,
      );
    } on SocketException {
      rethrow;
    } on PlaylistException {
      rethrow;
    } finally {
      _removeFetch();
      _tryCloseCient();
    }
  }

  ///Yields all `videos` from a given playlist
  static Stream<VideoController> getVideosFromPlaylist(
      String playlistId) async* {
    _client ??= yt_explode.YoutubeExplode();
    _addFetch();

    try {
      await for (final yt_explode.Video vid
          in _client!.playlists.getVideos(playlistId)) {
        VideoController video = VideoController(
          video: Video(
            id: vid.id.toString(),
            title: vid.title,
            author: vid.author,
            thumbnailUrl: vid.thumbnails.mediumResUrl,
          ),
        );
        yield video;
      }
    } on SocketException {
      rethrow;
    } finally {
      _removeFetch();
      _tryCloseCient();
    }
  }

  //__ Singleton
  static final FetchingService _instance = FetchingService._();
  factory FetchingService() => _instance;
  FetchingService._();
}
