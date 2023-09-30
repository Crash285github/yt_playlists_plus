import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/model/enums/playlist_status.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';

class SaveButton extends StatelessWidget {
  final PlaylistController playlist;
  const SaveButton({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        await PlaylistsService().save();
        playlist.clearPending();
        playlist.status = PlaylistStatus.saved;
      },
      tooltip: "Save",
      child: const Icon(
        Icons.save,
        size: 30,
      ),
    );
  }
}
