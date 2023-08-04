import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';

class VideoHistory {
  final String id, title;
  final VideoStatus status;

  VideoHistory({
    required this.id,
    required this.title,
    required this.status,
  });

  static VideoHistory fromVideo({required Video video, VideoStatus? status}) {
    return VideoHistory(
        id: video.id, title: video.title, status: status ?? video.status);
  }

  @override
  bool operator ==(other) =>
      other is VideoHistory && id == other.id && status == other.status;

  @override
  int get hashCode => Object.hash(id, title);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'status': status.name,
      };

  VideoHistory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        status = VideoStatus.values.byName(json['status']);
}
