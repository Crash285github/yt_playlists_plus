import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:yt_playlists_plus/services/popup_controller/popup_controller.dart';
import 'package:yt_playlists_plus/services/popup_controller/show_context_menu.dart';
import 'package:yt_playlists_plus/view/templates/video_history/video_history_details.dart';
import 'package:yt_playlists_plus/view/templates/video_history/video_history_group_time.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
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
    Provider.of<Persistence>(context);

    final List<PopupMenuEntry<dynamic>> copyItems = [
      PopupMenuItem(
        child: const Center(child: Text("Open link")),
        onTap: () async {
          await launchUrl(
              Uri.parse("https://youtube.com/watch?v=${videoHistory.id}"));
        },
      ),
      const PopupMenuDivider(height: 0),
      PopupMenuItem(
        child: const Center(child: Text("Copy title")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: videoHistory.title));
        },
      ),
      PopupMenuItem(
        child: const Center(child: Text("Copy id")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: videoHistory.id));
        },
      ),
      PopupMenuItem(
        child: const Center(child: Text("Copy link")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(
              text: "www.youtube.com/watch?v=${videoHistory.id}"));
        },
      )
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (firstOfList) VideoHistoryGroupTime(time: videoHistory.time),
          AdaptiveGestureDetector(
            onTrigger: (offset) => PopUpController().showContextMenu(
                context: context, offset: offset, items: copyItems),
            child: Card(
              margin: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  top: firstOfList ? 4 : 1,
                  bottom: lastOfList ? 10 : 1),
              surfaceTintColor: videoHistory.status.color,
              shape: RoundedRectangleBorder(
                  borderRadius: radiusBuilder(weakCorner: 3)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    VideoHistoryDetails(
                      title: videoHistory.title,
                      author: videoHistory.author,
                      time: videoHistory.time,
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
      ),
    );
  }
}
