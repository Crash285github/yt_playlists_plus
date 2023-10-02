import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/videos/planned/planned_panel.dart';

class PlannedButton extends StatelessWidget {
  final PlaylistController controller;
  const PlannedButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          elevation: 0,
          backgroundColor: Colors.transparent,
          builder: (context) => PlannedPanel(
            planned: controller.planned,
            scrollController: ScrollController(),
            onHandleTapped: null,
          ),
        );
      },
      tooltip: "Planned",
      child: const Icon(
        Icons.draw_outlined,
        size: 30,
      ),
    );
  }
}
