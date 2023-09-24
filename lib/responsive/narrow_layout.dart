import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/services/popup_service.dart';
import 'package:yt_playlists_plus/pages/home_page/home_page.dart';
import 'package:yt_playlists_plus/pages/playlist_page/playlist_page.dart';
import 'package:yt_playlists_plus/services/playlists_service.dart';

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
                  PopUpService.openConfirmDialog(
                    context: context,
                    title: "Delete \"${playlist.title}\"?",
                    content: "This will erase all of the playlist's data.",
                  ).then(
                    (value) {
                      if (value ?? false) {
                        PlaylistsService().remove(playlist);
                        PlaylistsService().save();
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
