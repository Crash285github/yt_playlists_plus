import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';
import 'package:yt_playlists_plus/enums/playlist_status.dart';
import 'package:yt_playlists_plus/controller/export_import_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/playlist_page.dart';

extension AppBarActions on PlaylistPage {
  List<Widget>? appBarActions({
    required PlaylistController playlist,
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
                  ExportImportController().disable();
                  await playlist.fetchVideos();
                  await playlist.check();
                } on SocketException catch (_) {
                  return;
                } finally {
                  ExportImportController().tryEnable();
                  PlaylistsController().save();
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
