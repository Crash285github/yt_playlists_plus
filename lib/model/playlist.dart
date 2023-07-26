import 'package:yt_playlists_plus/model/client.dart';
import 'package:yt_playlists_plus/model/video.dart';

class Playlist {
  String id;
  String title;
  String author;
  String thumbnailUrl;
  Set<Video> videos = {};
  final Set<Video> _fetch = {};

  Playlist({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
  });

  ///Adds a video to the Set of videos
  ///
  ///returns `true` if successful
  bool add(Video video) => videos.add(video);

  ///Removes a video from the Set of videos
  ///
  ///returns `true` if successful
  bool remove(Video video) => videos.remove(video);

  ///Returns the difference of the `local` videos and the `fetched` videos
  ///
  ///Video's function is set to `remove`
  Set<Video> getMissing() {
    Set<Video> missing = videos.difference(_fetch);

    for (var video in missing) {
      video.function = () => remove(video);
    }

    return missing;
  }

  ///Returns the difference of the `fetched` videos and the `local` videos
  ///
  ///Video's function is set to `add`
  Set<Video> getAdded() {
    Set<Video> added = _fetch.difference(videos);

    for (var video in added) {
      video.function = () => add(video);
    }

    return added;
  }

  ///Fetches the videos of the playlist and adds them to it's `fetch set`
  Stream<Video> getVideos(YoutubeClient client) async* {
    await for (Video video in client.getVideosFromPlaylist(id)) {
      _fetch.add(video);
      yield video;
    }
  }

  @override
  String toString() => "\nPlaylist(title: $title, author: $author)";

  ///returns the `Set` of [videos] with the playlist
  String toExtendedString() =>
      "\nPlaylist(title: $title, author: $author, videos: [${videos.toString()}])";

  ///Converts a `json` Object into a `Playlist` Object
  Playlist.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        author = json['author'],
        thumbnailUrl = json['thumbnailUrl'],
        videos = (json['videos'] as List).map((e) => Video.fromJson(e)).toSet();

  ///Converts a `Playlist` Object into a `json` Object
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'thumbnailUrl': thumbnailUrl,
        'videos': videos.map((e) => e.toJson()).toList(),
      };
}
