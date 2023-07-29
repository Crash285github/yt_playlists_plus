import 'package:yt_playlists_plus/model/video/video_status.dart';

class Video {
  String id, title, author, thumbnailUrl;
  VideoStatus status;

  ///What the Video should do when tapped on it's Widget
  ///
  ///The add/remove functions are assigned usually
  bool Function()? function;

  Video({
    required this.id,
    required this.title,
    required this.author,
    required this.thumbnailUrl,
    this.status = VideoStatus.hidden,
  });

  @override
  String toString() {
    return "\nVideo(title: $title, author: $author)";
  }

  @override
  bool operator ==(other) => other is Video && id == other.id;

  @override
  int get hashCode => Object.hash(id, title);

  ///Converts a `json` Object into a `Video` Object
  Video.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        author = json['author'],
        thumbnailUrl = json['thumbnailUrl'],
        status = VideoStatus.values.byName(json['status']);

  ///Converts a `Video` Object into a `json` Object
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'thumbnailUrl': thumbnailUrl,
        'status': status.name
      };

  factory Video.deepCopy(Video source) => Video(
        id: source.id,
        title: source.title,
        author: source.author,
        thumbnailUrl: source.thumbnailUrl,
      );
}
