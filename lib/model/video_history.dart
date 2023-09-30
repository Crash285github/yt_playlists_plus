import 'package:yt_playlists_plus/controller/video_controller.dart';
import 'package:yt_playlists_plus/model/enums/video_status.dart';

class VideoHistory {
  final String id, title, author;
  final VideoStatus status;
  late final DateTime time;

  VideoHistory({
    required this.id,
    required this.title,
    required this.author,
    required this.status,
  }) {
    time = DateTime.now();
  }

  ///Convert a Video to a VideoHistory object
  static VideoHistory fromVideo(
      {required VideoController video, VideoStatus? status}) {
    return VideoHistory(
        id: video.id,
        title: video.title,
        author: video.author,
        status: status ?? video.status);
  }

  @override
  bool operator ==(other) =>
      other is VideoHistory && id == other.id && status == other.status;

  @override
  int get hashCode => Object.hash(id, title);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'status': status.name,
        'time': time.toIso8601String()
      };

  VideoHistory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        author = json['author'],
        status = VideoStatus.values.byName(json['status']),
        time = DateTime.parse(json['time']);
}
