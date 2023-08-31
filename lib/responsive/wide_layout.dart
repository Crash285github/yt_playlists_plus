import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/pages_export.dart';

class WideLayout extends StatefulWidget {
  const WideLayout({super.key});

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  Playlist? _playlist;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          flex: 3,
          child: _playlist == null
              ? Scaffold(
                  body: Center(
                    child: Text(
                      "Tap on a playlist to show data.",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.5)),
                    ),
                  ),
                )
              : ListenableProvider.value(
                  value: _playlist,
                  child: const PlaylistPage(),
                ),
        ),
        Expanded(
          flex: 2,
          child: HomePage(
            onPlaylistTap: (Playlist playlist) {
              setState(() {
                _playlist = playlist;
              });
            },
          ),
        ),
      ],
    );
  }
}
