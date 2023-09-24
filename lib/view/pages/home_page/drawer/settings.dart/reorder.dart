import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/reorder_service.dart';

class ReorderPlaylistsSetting extends StatelessWidget {
  const ReorderPlaylistsSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Reorder playlists"),
      leading: const Icon(Icons.sort),
      onTap: () {
        Navigator.of(context).pop();
        ReorderService().enable();
      },
    );
  }
}
