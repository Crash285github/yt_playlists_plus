import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class ReorderPlaylistsSetting extends StatelessWidget {
  const ReorderPlaylistsSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Reorder playlists"),
      leading: const Icon(Icons.sort),
      onTap: () {
        Navigator.of(context).pop();
        Persistence.enableReorder();
      },
    );
  }
}
