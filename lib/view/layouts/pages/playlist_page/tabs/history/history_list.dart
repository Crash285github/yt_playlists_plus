import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/extensions/equal_seconds_since_epoch.dart';
import 'package:yt_playlists_plus/model/video_history.dart';
import 'package:yt_playlists_plus/view/templates/video_history/video_history_view.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/history_limit_service.dart';
import 'package:yt_playlists_plus/view/bottom_padding.dart';

class HistoryList extends StatefulWidget {
  final List<VideoHistory> history;

  const HistoryList({
    super.key,
    required this.history,
  });

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    int? limit = Provider.of<HistoryLimitService>(context).limit;
    int historyLimit = limit ?? widget.history.length;
    int index = 0;

    List<VideoHistory> displayedHistory =
        widget.history.reversed.take(historyLimit).toList();

    bool equalTime(int index1, int index2) {
      try {
        DateTime time1 = displayedHistory[index1].time;
        DateTime time2 = displayedHistory[index2].time;
        return time1.equalSecondsSinceEpoch(time2);
      } on RangeError {
        return false;
      }
    }

    return Expanded(
      child: ListView(
        children: [
          ...displayedHistory.map(
            (videoHistory) {
              index++;
              return VideoHistoryView(
                videoHistory: videoHistory,
                firstOfList: index == 1 || !equalTime(index - 1, index - 2),
                lastOfList: index == widget.history.length ||
                    !equalTime(index - 1, index),
              );
            },
          ),
          const BottomPadding(androidHeight: 20, windowsHeight: 10)
        ],
      ),
    );
  }
}
