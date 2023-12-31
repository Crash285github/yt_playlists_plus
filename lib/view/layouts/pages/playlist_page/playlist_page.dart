import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/services/popup_service/show_context_menu.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/appbar_actions.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/playlist_page_body.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/playlist_tab_bar.dart';
import 'package:yt_playlists_plus/view/templates/adatpive_gesture_detector.dart';

class PlaylistPage extends StatelessWidget {
  final Function() onDelete;
  const PlaylistPage({
    super.key,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    PlaylistController playlist = Provider.of<PlaylistController>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: AdaptiveGestureDetector(
            onTrigger: (offset) => PopUpService().showContextMenu(
                context: context, offset: offset, playlist: playlist),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(playlist.title),
            ),
          ),
          centerTitle: true,
          actions: appBarActions(playlist: playlist),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: PlaylistTabBar(status: playlist.status),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: PlaylistPageBody(playlist: playlist),
      ),
    );
  }
}
