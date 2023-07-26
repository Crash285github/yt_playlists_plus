import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt_explode;
import 'package:yt_playlists_plus/model/playlist.dart';
import 'package:yt_playlists_plus/model/video.dart';

class YoutubeClient {
  late yt_explode.YoutubeExplode _client;

  ///Constructor, initializes the `YoutubeExplode()` client
  ///
  ///Don't forget to use the [close] function to close the client after use
  YoutubeClient() {
    _client = yt_explode.YoutubeExplode();
  }

  ///Closes the client
  close() {
    _client.close();
  }

  ///Searches Youtube playlists with a given `query`
  Stream<Playlist> searchPlaylists(String query) async* {
    query += " ";
    var result = await _client.search
        .searchContent(query, filter: yt_explode.TypeFilters.playlist);

    for (var list in result) {
      yield await _getPlaylist(
          (list as yt_explode.SearchPlaylist).playlistId.toString());
    }
  }

  Future<Playlist> _getPlaylist(String playlistId) async {
    var result = await _client.playlists.get(playlistId);

    return Playlist(
      id: result.id.toString(),
      title: result.title,
      author: result.author,
      thumbnailUrl: result.thumbnails.highResUrl,
    );
  }

  ///Yields all `videos` from a given playlist
  Stream<Video> getVideosFromPlaylist(String playlistId) async* {
    await for (yt_explode.Video vid
        in _client.playlists.getVideos(playlistId)) {
      Video video = Video(
          id: vid.id.toString(),
          title: vid.title,
          author: vid.author,
          thumbnailUrl: vid.thumbnails.highResUrl);
      yield video;
    }
  }
}