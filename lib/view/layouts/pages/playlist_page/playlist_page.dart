import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/services/popup_controller/popup_controller.dart';
import 'package:yt_playlists_plus/services/popup_controller/show_context_menu.dart';
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
    Playlist playlist = Provider.of<Playlist>(context);

    final List<PopupMenuEntry<dynamic>> copyItems = [
      PopupMenuItem(
        child: const Center(child: Text("Copy title")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: playlist.title));
        },
      ),
      PopupMenuItem(
        child: const Center(child: Text("Copy id")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: playlist.id));
        },
      ),
      PopupMenuItem(
        child: const Center(child: Text("Copy url")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(
              text: "www.youtube.com/playlist?list=${playlist.id}"));
        },
      )
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: AdaptiveGestureDetector(
            onTrigger: (offset) => PopUpController().showContextMenu(
                context: context, offset: offset, items: copyItems),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(playlist.title),
            ),
          ),
          centerTitle: true,
          actions: appBarActions(playlist: playlist),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: PlaylistTabBar(playlist: playlist),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: PlaylistPageBody(playlist: playlist),
      ),
    );
  }
}
