import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/extensions/equal_seconds_since_epoch.dart';
import 'package:yt_playlists_plus/model/video_history.dart';
import 'package:yt_playlists_plus/view/templates/video_history/video_history_view.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/history_limit_controller.dart';
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

class _HistoryListState extends State<HistoryList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    int? limit = Provider.of<HistoryLimitController>(context).limit;
    int historyLimit = limit ?? widget.history.length;

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

    int index = 0;
    return Expanded(
      child: ListView(
        children: [
          ...displayedHistory.map(
            (videoHistory) {
              final bool isFirst = index == 0 || !equalTime(index, index - 1);
              final bool isLast =
                  index == historyLimit - 1 || !equalTime(index + 1, index);
              index++;
              return VideoHistoryView(
                videoHistory: videoHistory,
                firstOfList: isFirst,
                lastOfList: isLast,
              );
            },
          ),
          const AdaptiveHeightBox()
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
