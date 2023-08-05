import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';

class HistoryWidget extends StatelessWidget {
  final VideoHistory videoHistory;
  const HistoryWidget({super.key, required this.videoHistory});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Tooltip(
                message: videoHistory.title,
                child: Text(
                  videoHistory.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Tooltip(
              message: videoHistory.status == VideoStatus.missing
                  ? "Removed"
                  : "Added",
              child: Icon(
                videoHistory.status.icon,
                color: videoHistory.status.color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
