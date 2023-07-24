import 'package:yt_playlists_plus/model/client.dart';
import 'package:yt_playlists_plus/model/video.dart';

class Playlist {
  String id;
  String title;
  String author;
  String thumbnailUrl;
  List<Video> videos = [];

  Playlist({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
  });

  bool tryAddVideo(Video video) {
    if (!videos.contains(video)) {
      videos.add(video);
      return true;
    }
    return false;
  }

  bool tryRemoveVideo(Video video) {
    if (videos.contains(video)) {
      videos.remove(video);
      return true;
    }
    return false;
  }

  Stream<Video> getVideos(String playlistId, YoutubeClient client) async* {
    await for (Video video in client.getVideosFromPlaylist(id)) {
      tryAddVideo(video);
      yield video;
    }
  }

  @override
  String toString() {
    return "Playlist(id: $id, title: $title, author: $author, thumbnailUrl: $thumbnailUrl)";
  }
}
