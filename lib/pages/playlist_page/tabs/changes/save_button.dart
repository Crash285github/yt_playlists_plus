import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class SaveButton extends StatelessWidget {
  final Playlist playlist;
  const SaveButton({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
      scale: playlist.modified == 0 ? 0 : 1,
      child: FloatingActionButton(
        onPressed: () async {
          await Persistence.savePlaylists();
          playlist.clearPending();
          playlist.setStatus(PlaylistStatus.saved);
        },
        tooltip: "Save",
        child: const Icon(
          Icons.save,
          size: 30,
        ),
      ),
    );
  }
}
