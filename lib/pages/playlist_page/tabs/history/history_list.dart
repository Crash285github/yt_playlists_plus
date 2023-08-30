import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/history_widget.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

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
    int historyLimit = Persistence.historyLimit ?? widget.history.length;
    int index = 0;

    return Expanded(
      child: ListView(
        children: [
          ...widget.history.reversed.take(historyLimit).map(
            (videoHistory) {
              index++;
              return HistoryWidget(
                videoHistory: videoHistory,
                firstOfList: index == 1,
                lastOfList: index == widget.history.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
