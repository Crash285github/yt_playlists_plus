import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/history_widget.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/widgets/bottom_padding.dart';

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
    Provider.of<Persistence>(context);
    int historyLimit = Persistence.historyLimit ?? widget.history.length;
    int index = 0;

    List<VideoHistory> displayedHistory =
        widget.history.reversed.take(historyLimit).toList();

    bool equalTime(int index1, int index2) {
      try {
        DateTime time1 = displayedHistory[index1].time;
        DateTime time2 = displayedHistory[index2].time;
        return time1.millisecondsSinceEpoch ~/ 1000 ==
            time2.millisecondsSinceEpoch ~/ 1000;
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
              return HistoryWidget(
                videoHistory: videoHistory,
                firstOfGroup: index == 1 || !equalTime(index - 1, index - 2),
                lastOfGroup: index == widget.history.length ||
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
