import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yt_playlists_plus/model/popup_manager.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:yt_playlists_plus/constants.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/history_widget/history_details.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/history_widget/history_group_time.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/widgets/adatpive_gesture_detector.dart';
import 'package:yt_playlists_plus/widgets/icard.dart';

class HistoryWidget extends ICardWidget {
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

  String formattedTime(DateTime time) {
    final String month = switch (time.month) {
      1 => 'Jan.',
      2 => 'Feb.',
      3 => 'Mar.',
      4 => 'Apr.',
      5 => 'May.',
      6 => 'Jun.',
      7 => 'Jul.',
      8 => 'Aug.',
      9 => 'Sep.',
      10 => 'Okt.',
      11 => 'Nov.',
      12 => 'Dec.',
      _ => 'error'
    };

    String addZeroIfBelow10(int time) => "${time > 9 ? time : '0$time'}";

    return "${time.year}. $month ${time.day}. ${addZeroIfBelow10(time.hour)}:${addZeroIfBelow10(time.minute)}:${addZeroIfBelow10(time.second)}";
  }

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
      const PopupMenuDivider(),
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
          if (firstOfGroup)
            HistoryGroupTime(time: formattedTime(videoHistory.time)),
          AdaptiveGestureDetector(
            onLongOrSecondaryTap: (offset) => PopUpManager.showContextMenu(
                context: context, offset: offset, items: copyItems),
            child: Card(
              margin: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  top: firstOfGroup ? 4 : 1,
                  bottom: lastOfGroup ? 10 : 1),
              surfaceTintColor: videoHistory.status.color,
              shape: cardBorder(
                  firstOfList: firstOfGroup,
                  lastOfList: lastOfGroup,
                  weakCorner: 3),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HistoryDetails(
                      title: videoHistory.title,
                      author: videoHistory.author,
                      time: formattedTime(videoHistory.time),
                      timeago: timeago.format(videoHistory.time),
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
