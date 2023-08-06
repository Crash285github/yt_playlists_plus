import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tab_changes.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tab_more.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tab_history.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    Playlist playlist = Provider.of<Playlist>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(playlist.title),
          centerTitle: true,
          actions: [AppBarActions(playlist: playlist)],
          bottom: _playlistPageTabBar(playlist: playlist, context: context),
          flexibleSpace: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 90),
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Opacity(
                opacity: 0.1,
                child: Image.network(
                  playlist.thumbnailUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ChangesTab(
              added: playlist.getAdded(),
              missing: playlist.getMissing(),
            ),
            MoreTab(playlist: playlist),
            HistoryTab(history: playlist.history),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Persistence.save();
            playlist.clearPending();
          },
          tooltip: "Save",
          child: const Icon(
            Icons.save,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class AppBarActions extends StatelessWidget {
  final Playlist playlist;
  const AppBarActions({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: "Refresh",
          icon: const Icon(Icons.refresh_outlined),
          onPressed: playlist.status == PlaylistStatus.fetching
              ? null
              : () async {
                  await playlist.fetchVideos().drain();
                  playlist.check();
                },
        ),
        IconButton(
          onPressed: () {
            Persistence.removePlaylist(playlist);
            Persistence.save();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
          tooltip: "Delete",
        ),
      ],
    );
  }
}

TabBar _playlistPageTabBar(
    {required Playlist playlist, required BuildContext context}) {
  return TabBar(
    isScrollable: true,
    tabs: [
      Tab(
        child: Stack(clipBehavior: Clip.none, children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.change_circle_outlined),
              SizedBox(width: 10),
              Text("Changes"),
            ],
          ),
          playlist.status != PlaylistStatus.unChanged &&
                  playlist.status != PlaylistStatus.unChecked &&
                  playlist.status != PlaylistStatus.downloaded
              ? Positioned(
                  left: 20,
                  top: -5,
                  child: Icon(
                    playlist.status.icon,
                    size: 15,
                    color: playlist.status.color,
                  ),
                )
              : const SizedBox.shrink()
        ]),
      ),
      const Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.more_horiz),
            SizedBox(width: 10),
            Text("More"),
          ],
        ),
      ),
      const Tab(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history),
            SizedBox(width: 10),
            Text("History"),
          ],
        ),
      ),
    ],
  );
}
