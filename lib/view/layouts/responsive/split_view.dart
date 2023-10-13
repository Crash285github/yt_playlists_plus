import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/config.dart';
import 'package:yt_playlists_plus/enums/split_layout_enum.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/services/popup_service/open_confirm_dialog.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/view/layouts/pages/home_page/home_page.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/playlist_page.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/split_layout_controller.dart';

///Shows the `HomePage` on the left side and a `PlaylistPage` on the right
///
///The currently showing `Playlist` can be modified with
///[SplitViewState.playlist]
class SplitView extends StatefulWidget {
  const SplitView({super.key});

  @override
  State<SplitView> createState() => SplitViewState();
}

class SplitViewState extends State<SplitView> {
  static PlaylistController? playlist;

  @override
  Widget build(BuildContext context) {
    SplitLayout portions = Provider.of<SplitLayoutController>(context).portions;

    return Scaffold(
      body: Row(
        //hack: to avoid BackdropFilter blurring the HomePage, it has to be
        //hack: rendered after PlaylistPage
        //hack: so to still make the HomePage appear on the left,
        //hack: the direction has to be reversed
        textDirection: TextDirection.rtl,
        children: [
          //?? right side
          Expanded(
            flex: portions.right,
            child: Navigator(
              key: AppConfig.rightKey,
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => playlist == null
                    ? Scaffold(
                        body: Center(
                          child: Text(
                            "Tap on a playlist to show data.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
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
                            PopUpService()
                                .openConfirmDialog(
                              context: context,
                              title: "Delete \"${playlist!.title}\"?",
                              content:
                                  "This will erase all of the playlist's data.",
                            )
                                .then((value) {
                              if (value ?? false) {
                                PlaylistsController()
                                  ..remove(playlist!)
                                  ..save();

                                setState(() {
                                  playlist = null;
                                });
                              }
                            });
                          },
                        ),
                      ),
              ),
            ),
          ),
          //?? left side
          Expanded(
            flex: portions.left,
            child: Navigator(
              key: AppConfig.leftKey,
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => HomePage(
                  onPlaylistTap: (PlaylistController selected) {
                    setState(() {
                      playlist = selected;
                    });
                    if (AppConfig.rightKey.currentContext != null) {
                      Navigator.of(AppConfig.rightKey.currentContext!)
                          .maybePop();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
