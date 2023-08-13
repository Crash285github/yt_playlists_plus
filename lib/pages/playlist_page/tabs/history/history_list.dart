import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/history_widget.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/history_top_row.dart';
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
    int index = 0;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: HistoryTopRow(
            onClearPressed: widget.history.isEmpty
                ? null
                : () => setState(() => widget.history.clear()),
          ),
        ),
        const Divider(),
        const SizedBox(height: 16),
        ...widget.history.reversed.map(
          (videoHistory) {
            index++;
            return HistoryWidget(
              videoHistory: videoHistory,
              firstOfList: index == 1,
              lastOfList: index == widget.history.length,
            );
          },
        ),
        const BottomPadding(),
      ],
    );
  }
}
