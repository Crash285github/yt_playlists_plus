import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';

///Displays the `Video`'s [status]
class VideoStatusWidget extends StatelessWidget {
  final VideoStatus status;

  const VideoStatusWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Tooltip(
        message: status.displayName,
        child: Icon(status.icon, color: status.color),
      ),
    );
  }
}
