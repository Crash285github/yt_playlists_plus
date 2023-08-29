import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/popup_manager.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/empty.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/history_list.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/history_top_row.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

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
              : () async {
                  PopUpManager.openConfirmDialog(
                    context: context,
                    title: "Clear history?",
                  ).then((value) {
                    if (value ?? false) {
                      setState(() => widget.history.clear());
                      Persistence.savePlaylists();
                    }
                  });
                },
        ),
        const Divider(),
        widget.history.isEmpty
            ? const EmptyHistory()
            : HistoryList(history: widget.history),
      ],
    );
  }
}
