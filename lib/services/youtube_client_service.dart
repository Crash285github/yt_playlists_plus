import 'dart:io';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt_explode;
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_exception.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/services/playlists_service.dart';

///Youtube fetching service
///
///Wraps the `YoutubeExplode` client
class YoutubeClient {
  static late yt_explode.YoutubeExplode _client;

  //Singleton
  static final YoutubeClient _instance = YoutubeClient._internal();
  YoutubeClient._internal() {
    _client = yt_explode.YoutubeExplode();
  }

  ///Constructor, initializes the `YoutubeExplode()` client
  ///
  ///You can use it anywhere, since it uses `Singleton` design pattern
  factory YoutubeClient() => _instance;

  ///Searches Youtube playlists with a given `query`
  ///
  ///Yields results
  static Stream<Playlist> searchByQuery({
    required String query,
    List<String>? excludedWords,
  }) async* {
    query += " "; //hack: it gives better results

    if (excludedWords != null) {
      for (final String word in excludedWords) {
        query += "-$word ";
      }
    }

    try {
      final yt_explode.SearchList<yt_explode.BaseSearchContent> result =
          await _client.search
              .searchContent(query, filter: yt_explode.TypeFilters.playlist);
      for (final yt_explode.BaseSearchContent list in result) {
        yield await _getPlaylist(
            (list as yt_explode.SearchPlaylist).playlistId.toString());
      }
    } on SocketException {
      rethrow;
    } on PlaylistException {
      return;
    }
  }

  ///Returns a single Playlist from the given `url`
  ///
  ///Returns null if the url is invalid or the Playlist ID doesn't exist
  static Future<Playlist?> searchByLink({required String url}) async {
    final String id = url.split("?list=")[1].split('&')[0];

    //if already contains
    if (PlaylistsService().playlists.any((final Playlist pl) => pl.id == id)) {
      return null;
    }

    try {
      final Playlist playlist = await _getPlaylist(id);
      return playlist;
    } on SocketException {
      rethrow;
    } on PlaylistException {
      return null;
    }
  }

  static Future<bool> existsPlaylist(String playlistId) async {
    try {
      final yt_explode.Playlist result =
          await _client.playlists.get(playlistId);
      return result.title != "";
    } on Exception {
      return false;
    }
  }

  //? gets playlist information
  static Future<Playlist> _getPlaylist(String playlistId) async {
    try {
      final yt_explode.Playlist result =
          await _client.playlists.get(playlistId);

      String author = result.author;
      if (!result.author.startsWith("by")) author = "by ${result.author}";

      return Playlist(
        id: result.id.toString(),
        title: result.title,
        author: author,
        length: result.videoCount,
        thumbnailUrl: "", //? at download
      );
    } on SocketException {
      rethrow;
    }
  }

  ///Yields all `videos` from a given playlist
  static Stream<Video> getVideosFromPlaylist(String playlistId) async* {
    try {
      await for (final yt_explode.Video vid
          in _client.playlists.getVideos(playlistId)) {
        Video video = Video(
          id: vid.id.toString(),
          title: vid.title,
          author: vid.author,
          thumbnailUrl: vid.thumbnails.mediumResUrl,
        );
        yield video;
      }
    } on SocketException {
      rethrow;
    }
  }
}
