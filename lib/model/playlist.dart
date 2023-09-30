import 'dart:convert';

import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/video_controller.dart';
import 'package:yt_playlists_plus/model/video_history.dart';

class Playlist {
  final String id;
  String title;
  String author;
  String thumbnailUrl;

  Playlist({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
  });

  Set<VideoController> videos = {};
  Set<String> planned = {};
  List<VideoHistory> history = [];

  ///Converts a `json` Object into a `Playlist` Object
  Playlist.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        author = json['author'],
        thumbnailUrl = json['thumbnailUrl'],
        videos = (json['videos'] as List)
            .map((video) => VideoController.fromJson(video))
            .toSet(),
        planned = Set.from(
            (jsonDecode(json['planned']) as List<dynamic>).cast<String>()),
        history = (json['history'] as List)
            .map((videoHistory) => VideoHistory.fromJson(videoHistory))
            .toList();

  ///Converts a `Playlist` Object into a `json` Object
  Map<String, dynamic> toJson() {
    int historyLimit = Persistence.historyLimit ?? history.length;
    return {
      'id': id,
      'title': title,
      'author': author,
      'thumbnailUrl': thumbnailUrl,
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
