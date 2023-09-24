import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/services/popup_service.dart';
import 'package:yt_playlists_plus/pages/playlist_page/appbar_actions.dart';
import 'package:yt_playlists_plus/pages/playlist_page/body.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabbar.dart';
import 'package:yt_playlists_plus/widgets/adatpive_gesture_detector.dart';

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
            onLongOrSecondaryTap: (offset) => PopUpService.showContextMenu(
                context: context, offset: offset, items: copyItems),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(playlist.title),
            ),
          ),
          centerTitle: true,
          actions: AppBarActions.build(
            context: context,
            playlist: playlist,
            onDelete: onDelete,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: PlaylistPageTabBar(
              playlist: playlist,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: PlaylistPageBody(playlist: playlist),
      ),
    );
  }
}
