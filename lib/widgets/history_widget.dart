import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryWidget extends StatelessWidget {
  final VideoHistory videoHistory;

  ///If true, the card will have rounded corners on the top half
  final bool firstOfList;

  ///If true, the card will have rounded corners on the bottom half
  final bool lastOfList;

  const HistoryWidget({
    super.key,
    required this.videoHistory,
    this.firstOfList = false,
    this.lastOfList = false,
  });

  @override
  Widget build(BuildContext context) {
    ShapeBorder borders;
    if (firstOfList && lastOfList) {
      borders = const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      );
    } else if (firstOfList) {
      borders = const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      );
    } else if (lastOfList) {
      borders = const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      );
    } else {
      borders = const Border();
    }

    return Card(
      shape: borders,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tooltip(
                    message: videoHistory.title,
                    child: Text(
                      videoHistory.title,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Text(
                    "${videoHistory.author} • ${timeago.format(videoHistory.time)}",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.grey,
                        ),
                  )
                ],
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
