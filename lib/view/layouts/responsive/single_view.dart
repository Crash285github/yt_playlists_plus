import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/services/popup_controller/open_confirm_dialog.dart';
import 'package:yt_playlists_plus/services/popup_controller/popup_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/home_page/home_page.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/playlist_page.dart';
import 'package:yt_playlists_plus/services/playlists_service.dart';

///Shows a singular page
class SingleView extends StatelessWidget {
  const SingleView({super.key});

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
                  PopUpController()
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