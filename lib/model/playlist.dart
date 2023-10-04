import 'dart:convert';

import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/model/video.dart';
import 'package:yt_playlists_plus/model/video_history.dart';

class Playlist {
  ///The unique identifier of the Playlist
  final String id;

  ///The title of the Playlist
  String title;

  ///The author of the Playlist
  String author;

  ///The url of the thumbnail of the Playlist
  String thumbnailUrl;

  ///The description of the Playlist
  String description;

  Playlist({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
    required this.description,
  });

  ///The `set` of Videos of the Playlist
  Set<Video> videos = {};

  ///The user-managed `set` of titles planned to be added to the Playlist
  Set<String> planned = {};

  ///The `list` of video history of the Playlist
  List<VideoHistory> history = [];

  @override
  String toString() => "\nPlaylist(title: $title, author: $author)";

  @override
  bool operator ==(other) => other is Playlist && id == other.id;

  @override
  int get hashCode => Object.hash(id, null);

  ///Converts a `json` Object into a `Playlist` Object
  Playlist.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'] ?? "<err>",
        author = json['author'] ?? "<err>",
        thumbnailUrl = json['thumbnailUrl'] ?? "<err>",
        description = json['description'] ?? "<err>",
        videos = (json['videos'] as List)
            .map((video) => Video.fromJson(video))
            .toSet(),
        planned = Set.from(
            (jsonDecode(json['planned']) as List<dynamic>).cast<String>()),
        history = (json['history'] as List)
            .map((videoHistory) => VideoHistory.fromJson(videoHistory))
            .toList();

  ///Converts a `Playlist` Object into a `json` Object
  Map<String, dynamic> toJson() {
    int historyLimit = Persistence.historyLimit.value ?? history.length;
    return {
      'id': id,
      'title': title,
      'author': author,
      'thumbnailUrl': thumbnailUrl,
      'description': description,
      'videos': videos.map((video) => video.toJson()).toList(),
      'planned': jsonEncode(planned.toList()),
      'history': history.reversed
          .take(historyLimit)
          .toList()
          .reversed
          .map((videoHistory) => videoHistory.toJson())
          .toList()
    };
  }
}

class PlaylistException implements Exception {
  final String message;

  PlaylistException(this.message);

  @override
  String toString() => 'PlaylistException: $message';
}
