import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';

class VideoStatusWidget extends StatelessWidget {
  final VideoStatus status;
  const VideoStatusWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    if (status == VideoStatus.hidden) return const SizedBox.shrink();

    Widget icon = Tooltip(
        message: status.displayName,
        child: Icon(
          status.icon,
          color: status.color,
        ));

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: icon,
    );
  }
}
