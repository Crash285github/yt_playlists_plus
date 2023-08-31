import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/popup_manager.dart';
import 'package:yt_playlists_plus/pages/pages_export.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage(
      onPlaylistTap: (Playlist playlist) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ListenableProvider.value(
              value: playlist,
              child: PlaylistPage(
                onDelete: () async {
                  PopUpManager.openConfirmDialog(
                    context: context,
                    title: "Delete \"${playlist.title}\"?",
                    content: "This will erase all of the playlist's data.",
                  ).then(
                    (value) {
                      if (value ?? false) {
                        Persistence.removePlaylist(playlist);
                        Persistence.savePlaylists();
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
