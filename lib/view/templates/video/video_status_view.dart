import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/video_status.dart';

///Displays the `Video`'s [status]
class VideoStatusView extends StatelessWidget {
  final VideoStatus status;

  const VideoStatusView({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Tooltip(
        message: status.displayName,
        child: Icon(status.icon, color: status.color),
      ),
    );
  }
}
