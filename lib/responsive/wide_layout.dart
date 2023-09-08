import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/popup_manager.dart';
import 'package:yt_playlists_plus/pages/pages_export.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/persistence/split_portions.dart';

class WideLayout extends StatefulWidget {
  const WideLayout({super.key});

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  static Playlist? _playlist;

  @override
  Widget build(BuildContext context) {
    Provider.of<ApplicationSplitPortions>(context);
    return Scaffold(
      body: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            flex: ApplicationSplitPortions.get().right,
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
                    child: PlaylistPage(
                      onDelete: () async {
                        PopUpManager.openConfirmDialog(
                          context: context,
                          title: "Delete \"${_playlist!.title}\"?",
                          content:
                              "This will erase all of the playlist's data.",
                        ).then((value) {
                          if (value ?? false) {
                            Persistence.removePlaylist(_playlist!);
                            Persistence.savePlaylists();
                            setState(() {
                              _playlist = null;
                            });
                          }
                        });
                      },
                    ),
                  ),
          ),
          Expanded(
            flex: ApplicationSplitPortions.get().left,
            child: HomePage(
              onPlaylistTap: (Playlist playlist) {
                setState(() {
                  _playlist = playlist;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
