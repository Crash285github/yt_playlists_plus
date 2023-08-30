import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class DisableReorderButton extends StatelessWidget {
  const DisableReorderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Persistence.disableReorder(),
      label: const Text("Finish"),
      icon: const Icon(
        Icons.done,
        size: 30,
      ),
    );
  }
}
