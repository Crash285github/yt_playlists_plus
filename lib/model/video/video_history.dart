import 'package:yt_playlists_plus/model/video/video_status.dart';

class VideoHistory {
  final String id, title;
  final VideoStatus status;

  VideoHistory({
    required this.id,
    required this.title,
    required this.status,
  });

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
