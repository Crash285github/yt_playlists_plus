import 'dart:io';

import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt_explode;
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_exception.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class YoutubeClient {
  late yt_explode.YoutubeExplode _client;

  //Singleton
  static final YoutubeClient _instance = YoutubeClient._internal();
  YoutubeClient._internal() {
    _client = yt_explode.YoutubeExplode();
  }

  ///Constructor, initializes the `YoutubeExplode()` client
  ///
  ///Don't forget to use the [close] function to close the client after use
  factory YoutubeClient() => _instance;

  ///Closes the client
  close() {
    _client.close();
  }

  ///Searches Youtube playlists with a given `query`
  Stream<Playlist> searchByQuery(
      {required String query, List<String>? excludedWords}) async* {
    query += " ";

    if (excludedWords != null) {
      for (var word in excludedWords) {
        query += "-$word ";
      }
    }

    try {
      var result = await _client.search
          .searchContent(query, filter: yt_explode.TypeFilters.playlist);
      for (var list in result) {
        yield await _getPlaylist(
            (list as yt_explode.SearchPlaylist).playlistId.toString());
      }
    } on SocketException catch (_) {
      rethrow;
    }
  }

  ///Returns a single Playlist from the given `url`
  ///
  ///Returns null if the url is invalid or the Playlist ID doesn't exist
  Future<Playlist?> searchByLink({required String url}) async {
    final String id = url.substring(url.length - 34, url.length);

    //if already contains
    if (Persistence.playlists.any((element) => element.id == id)) {
      return null;
    }

    try {
      Playlist playlist = await _getPlaylist(id);

      return playlist;
    } on SocketException catch (_) {
      rethrow;
    } on PlaylistException catch (_) {
      return null;
    }
  }

  Future<bool> existsPlaylist(String playlistId) async {
    try {
      var result = await _client.playlists.get(playlistId);
      return result.title != "";
    } catch (e) {
      return false;
    }
  }

  Future<Playlist> _getPlaylist(String playlistId) async {
    try {
      var result = await _client.playlists.get(playlistId);

      yt_explode.Video video =
          await _client.playlists.getVideos(result.id).first.onError(
        (error, stackTrace) {
          throw PlaylistException("Invalid PlaylistId");
        },
      );

      String author = result.author;
      if (!result.author.startsWith("by")) author = "by ${result.author}";

      return Playlist(
        id: result.id.toString(),
        title: result.title,
        author: author,
        thumbnailUrl: video.thumbnails.mediumResUrl,
      );
    } on SocketException catch (_) {
      rethrow;
    }
  }

  ///Yields all `videos` from a given playlist
  Stream<Video> getVideosFromPlaylist(String playlistId) async* {
    try {
      await for (yt_explode.Video vid
          in _client.playlists.getVideos(playlistId)) {
        Video video = Video(
            id: vid.id.toString(),
            title: vid.title,
            author: vid.author,
            thumbnailUrl: vid.thumbnails.mediumResUrl);
        yield video;
      }
    } on SocketException catch (_) {
      rethrow;
    }
  }
}
