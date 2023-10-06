import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/videos/planned/top_bar.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/videos/planned/planned_title.dart';

class PlannedList extends StatelessWidget {
  final ScrollController scrollController;
  final PlaylistController playlistController;
  final Function()? onAddPressed;
  final Function(String) onDeletePressed;
  final Function()? onHandleTapped;

  const PlannedList({
    super.key,
    required this.scrollController,
    required this.playlistController,
    required this.onAddPressed,
    required this.onDeletePressed,
    required this.onHandleTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(controller: scrollController, children: [
      ...TopBar.build(
        plannedSize: playlistController.planned.length,
        onAddPressed: onAddPressed,
        onHandleTapped: onHandleTapped,
      ),
      ...playlistController.planned.toList().reversed.map(
            (title) => PlannedTitle(
              title: title,
              onDeletePressed: () => onDeletePressed(title),
            ),
          ),
    ]);
  }
}
