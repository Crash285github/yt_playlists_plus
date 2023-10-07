import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/config.dart';
import 'package:yt_playlists_plus/model/video_history.dart';
import 'package:yt_playlists_plus/enums/video_status.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/services/popup_service/show_context_menu.dart';
import 'package:yt_playlists_plus/view/templates/video_history/video_history_details.dart';
import 'package:yt_playlists_plus/view/templates/video_history/video_history_group_time.dart';
import 'package:yt_playlists_plus/view/templates/adatpive_gesture_detector.dart';
import 'package:yt_playlists_plus/view/abstract_list_widget.dart';

class VideoHistoryView extends ListWidget {
  ///The data to display
  final VideoHistory videoHistory;

  const VideoHistoryView({
    super.key,
    super.firstOfList,
    super.lastOfList,
    required this.videoHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (firstOfList) VideoHistoryGroupTime(time: videoHistory.time),
        AdaptiveGestureDetector(
          onTrigger: (offset) => PopUpService().showContextMenu(
              context: context, offset: offset, history: videoHistory),
          child: Card(
            margin: EdgeInsets.only(
                left: AppConfig.cardTheme.margin!.horizontal,
                right: AppConfig.cardTheme.margin!.horizontal,
                top: firstOfList ? 4 : 1,
                bottom: lastOfList ? 10 : 1),
            surfaceTintColor: videoHistory.status.color,
            shape: RoundedRectangleBorder(borderRadius: radiusBuilder()),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  VideoHistoryDetails(
                    title: videoHistory.title,
                    author: videoHistory.author,
                    time: videoHistory.time,
                    amoledColor: videoHistory.status.color,
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
          ),
        ),
      ],
    );
  }
}
