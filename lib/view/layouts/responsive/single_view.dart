import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/services/popup_service/open_confirm_dialog.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/view/layouts/pages/home_page/home_page.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/playlist_page.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';

///Shows a singular page
class SingleView extends StatelessWidget {
  const SingleView({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage(
      onPlaylistTap: (PlaylistController playlist) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ListenableProvider.value(
              value: playlist,
              child: PlaylistPage(
                onDelete: () async {
                  PopUpService()
                      .openConfirmDialog(
                    context: context,
                    title: "Delete \"${playlist.title}\"?",
                    content: "This will erase all of the playlist's data.",
                  )
                      .then(
                    (value) {
                      if (value ?? false) {
                        PlaylistsService()
                          ..remove(playlist)
                          ..save();

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
