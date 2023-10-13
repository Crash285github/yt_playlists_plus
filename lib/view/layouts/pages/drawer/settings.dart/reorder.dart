import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/reorder_controller.dart';

class ReorderSetting extends StatelessWidget {
  const ReorderSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Reorder playlists"),
      leading: const Icon(Icons.sort),
      onTap: () {
        Navigator.of(context).pop(); //?? closes drawer
        ReorderController().enable();
      },
    );
  }
}
