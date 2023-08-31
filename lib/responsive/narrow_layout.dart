import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/pages_export.dart';

class NarrowLayout extends StatelessWidget {
  const NarrowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage(
      onPlaylistTap: (Playlist playlist) {
        Navigator.pushNamed(context, '/playlist', arguments: playlist);
      },
    );
  }
}
