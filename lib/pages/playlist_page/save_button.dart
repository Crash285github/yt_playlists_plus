import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class SaveButton extends StatelessWidget {
  final Playlist playlist;
  const SaveButton({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Persistence.savePlaylists();
        playlist.clearPending();
      },
      tooltip: "Save",
      child: const Icon(
        Icons.save,
        size: 30,
      ),
    );
  }
}
