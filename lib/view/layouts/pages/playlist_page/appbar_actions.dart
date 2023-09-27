import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/services/export_import_service.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/playlist_page.dart';

extension AppBarActions on PlaylistPage {
  List<Widget>? appBarActions({
    required Playlist playlist,
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
                  ExportImportService().disable();
                  await playlist.fetchVideos();
                  await playlist.check();
                } on SocketException catch (_) {
                  return;
                } finally {
                  ExportImportService().tryEnable();
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
