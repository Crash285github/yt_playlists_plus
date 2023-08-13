import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/empty.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/history_list.dart';
import '../../../../model/video/video_history.dart';

class HistoryTab extends StatelessWidget {
  final List<VideoHistory> history;
  const HistoryTab({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return history.isEmpty
        ? const EmptyHistory()
        : HistoryList(history: history);
  }
}
