import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';

class AppBarActions {
  static List<Widget>? build({
    required BuildContext context,
    required Playlist playlist,
    required Function() onDelete,
  }) {
    return [
      IconButton(
        tooltip: "Refresh",
        icon: const Icon(Icons.refresh_outlined),
        onPressed: playlist.status == PlaylistStatus.fetching ||
                playlist.status == PlaylistStatus.checking ||
                playlist.status == PlaylistStatus.downloading
            ? null
            : () async {
                try {
                  await playlist.fetchVideos();
                  await playlist.check();
                } on SocketException catch (_) {
                  return;
                }
              },
      ),
      IconButton(
        onPressed: onDelete,
        icon: const Icon(
          Icons.delete_outline,
          color: Colors.red,
        ),
        tooltip: "Delete",
      ),
    ];
  }
}
