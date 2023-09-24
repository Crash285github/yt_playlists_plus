import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yt_playlists_plus/services/popup_service.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:yt_playlists_plus/view/pages/playlist_page/tabs/history/history_widget/history_details.dart';
import 'package:yt_playlists_plus/view/pages/playlist_page/tabs/history/history_widget/history_group_time.dart';
import 'package:yt_playlists_plus/persistence.dart';
import 'package:yt_playlists_plus/view/widgets/adatpive_gesture_detector.dart';
import 'package:yt_playlists_plus/view/widgets/abstract_list_widget.dart';

class HistoryWidget extends ListWidget {
  ///The data to display
  final VideoHistory videoHistory;

  final bool firstOfGroup;
  final bool lastOfGroup;

  const HistoryWidget({
    super.key,
    this.firstOfGroup = false,
    this.lastOfGroup = false,
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
          if (firstOfGroup) HistoryGroupTime(time: videoHistory.time),
          AdaptiveGestureDetector(
            onTrigger: (offset) => PopUpService.showContextMenu(
                context: context, offset: offset, items: copyItems),
            child: Card(
              margin: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  top: firstOfGroup ? 4 : 1,
                  bottom: lastOfGroup ? 10 : 1),
              surfaceTintColor: videoHistory.status.color,
              shape: RoundedRectangleBorder(
                  borderRadius: radiusBuilder(weakCorner: 3)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HistoryDetails(
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
