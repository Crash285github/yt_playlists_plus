import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/empty.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/history_list.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/history_top_row.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';

class HistoryTab extends StatefulWidget {
  final List<VideoHistory> history;
  const HistoryTab({super.key, required this.history});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HistoryTopRow(
          onClearPressed: widget.history.isEmpty
              ? null
              : () => setState(() => widget.history.clear()),
        ),
        const Divider(),
        widget.history.isEmpty
            ? const EmptyHistory()
            : HistoryList(history: widget.history),
      ],
    );
  }
}
