import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt_explode;
import 'package:yt_playlists_plus/model/playlist.dart';
import 'package:yt_playlists_plus/model/video.dart';

class YoutubeClient {
  late yt_explode.YoutubeExplode _client;

  YoutubeClient() {
    _client = yt_explode.YoutubeExplode();
  }

  close() {
    _client.close();
  }

  Stream<Playlist> searchPlaylists(String query) async* {
    query += " ";
    var result = await _client.search
        .searchContent(query, filter: yt_explode.TypeFilters.playlist);

    for (var list in result) {
      yield await getPlaylist(
          (list as yt_explode.SearchPlaylist).playlistId.toString());
    }
  }

  Future<Playlist> getPlaylist(String playlistId) async {
    var result = await _client.playlists.get(playlistId);

    return Playlist(
      id: result.id.toString(),
      title: result.title,
      author: result.author,
      thumbnailUrl: result.thumbnails.highResUrl,
    );
  }

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
