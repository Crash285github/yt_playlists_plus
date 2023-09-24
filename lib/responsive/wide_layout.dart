import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/services/popup_service.dart';
import 'package:yt_playlists_plus/pages/home_page/home_page.dart';
import 'package:yt_playlists_plus/pages/playlist_page/playlist_page.dart';
import 'package:yt_playlists_plus/services/playlists_service.dart';
import 'package:yt_playlists_plus/services/settings_service/split_layout_service.dart';

class WideLayout extends StatefulWidget {
  const WideLayout({super.key});

  @override
  State<WideLayout> createState() => WideLayoutState();
}

class WideLayoutState extends State<WideLayout> {
  static Playlist? playlist;

  @override
  Widget build(BuildContext context) {
    SplitLayout portions = Provider.of<SplitLayoutService>(context).portions;

    return Scaffold(
      body: Row(
        textDirection: TextDirection.rtl,
        children: [
          //?? right side
          Expanded(
            flex: portions.right,
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
                        PopUpService.openConfirmDialog(
                          context: context,
                          title: "Delete \"${playlist!.title}\"?",
                          content:
                              "This will erase all of the playlist's data.",
                        ).then((value) {
                          if (value ?? false) {
                            PlaylistsService().remove(playlist!);
                            PlaylistsService().save();
                            setState(() {
                              playlist = null;
                            });
                          }
                        });
                      },
                    ),
                  ),
          ),
          //?? left side
          Expanded(
            flex: portions.left,
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
