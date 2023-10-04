import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';
import 'package:yt_playlists_plus/services/popup_service/open_confirm_dialog.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/history/empty_history.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/history/history_list.dart';
import 'package:yt_playlists_plus/model/video_history.dart';

class HistoryTab extends StatefulWidget {
  final List<VideoHistory> history;
  const HistoryTab({super.key, required this.history});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          widget.history.isEmpty
              ? const EmptyHistory()
              : HistoryList(history: widget.history),
        ],
      ),
      floatingActionButton: widget.history.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () async {
                PopUpService()
                    .openConfirmDialog(
                  context: context,
                  title: "Clear history?",
                )
                    .then((value) {
                  if (value ?? false) {
                    setState(() => widget.history.clear());
                    PlaylistsController().save();
                  }
                });
              },
              tooltip: "Clear history",
              child: const Icon(
                Icons.delete_sweep_outlined,
                size: 30,
              ),
            ),
    );
  }
}
