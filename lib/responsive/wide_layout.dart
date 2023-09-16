import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/popup_manager.dart';
import 'package:yt_playlists_plus/pages/home_page/home_page.dart';
import 'package:yt_playlists_plus/pages/playlist_page/playlist_page.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/persistence/split_portions.dart';

class WideLayout extends StatefulWidget {
  const WideLayout({super.key});

  @override
  State<WideLayout> createState() => WideLayoutState();
}

class WideLayoutState extends State<WideLayout> {
  static Playlist? playlist;

  @override
  Widget build(BuildContext context) {
    Provider.of<ApplicationSplitPortions>(context);
    return Scaffold(
      body: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            flex: ApplicationSplitPortions.get().right,
            child: playlist == null
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
                    value: playlist,
                    child: PlaylistPage(
                      onDelete: () async {
                        PopUpManager.openConfirmDialog(
                          context: context,
                          title: "Delete \"${playlist!.title}\"?",
                          content:
                              "This will erase all of the playlist's data.",
                        ).then((value) {
                          if (value ?? false) {
                            Persistence.removePlaylist(playlist!);
                            Persistence.savePlaylists();
                            setState(() {
                              playlist = null;
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
              onPlaylistTap: (Playlist pl) {
                setState(() {
                  playlist = pl;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
