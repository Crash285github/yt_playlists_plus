import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';

class Video extends ChangeNotifier {
  final String id;
  String title, author, thumbnailUrl;

  ///The video's current status
  VideoStatus get status => _status;
  VideoStatus _status = VideoStatus.hidden;

  ///What the Video should do when tapped on it's Widget
  ///
  ///The add/remove functions are assigned usually
  Function()? function;

  Video({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
  });

  ///Creates a copy if a Video
  factory Video.deepCopy(Video source) => Video(
        id: source.id,
        title: source.title,
        author: source.author,
        thumbnailUrl: source.thumbnailUrl,
      );

  ///Changes status & alerts listeners
  setStatus(VideoStatus newStatus) {
    _status = newStatus;
    notifyListeners();
  }

  @override
  String toString() {
    return "\nVideo(title: $title, author: $author)";
  }

  @override
  bool operator ==(other) => other is Video && id == other.id;

  @override
  int get hashCode => Object.hash(id, null);

  ///Converts a `json` Object into a `Video` Object
  Video.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        author = json['author'],
        thumbnailUrl = json['thumbnailUrl'],
        _status = VideoStatus.hidden;

  ///Converts a `Video` Object into a `json` Object
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'thumbnailUrl': thumbnailUrl,
      };
}
