import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:yt_playlists_plus/widgets/i_card.dart';

class HistoryWidget extends ICardWidget {
  ///The data to display
  final VideoHistory videoHistory;

  const HistoryWidget({
    super.key,
    super.firstOfList = false,
    super.lastOfList = false,
    required this.videoHistory,
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
