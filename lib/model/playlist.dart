import 'package:yt_playlists_plus/model/client.dart';
import 'package:yt_playlists_plus/model/video.dart';

class Playlist {
  String id;
  String title;
  String author;
  String thumbnailUrl;
  final Set<Video> videos = {};
  final Set<Video> _fetch = {};

  Playlist({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
  });

  bool add(Video video) => videos.add(video);

  bool remove(Video video) => videos.remove(video);

  Set<Video> getMissing() => videos.difference(_fetch);

  Set<Video> getAdded() => _fetch.difference(videos);

  Stream<Video> getVideos(YoutubeClient client) async* {
    await for (Video video in client.getVideosFromPlaylist(id)) {
      if (videos.contains(video)) {}
      _fetch.add(video);
      yield video;
    }
  }

  @override
  String toString() {
    return "\nPlaylist(title: $title, author: $author)";
  }
}
