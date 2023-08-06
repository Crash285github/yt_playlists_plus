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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(playlist.title),
          centerTitle: true,
          actions: [AppBarActions(playlist: playlist)],
          bottom: _playlistPageTabBar(playlist: playlist, context: context),
          backgroundColor: Colors.transparent,
        ),
        body: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: SizedBox(
                width: double.infinity,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Opacity(
                    opacity: 0.7,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        playlist.thumbnailUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: SafeArea(
              child: TabBarView(
                children: [
                  ChangesTab(
                    added: playlist.getAdded(),
                    missing: playlist.getMissing(),
                  ),
                  MoreTab(playlist: playlist),
                  HistoryTab(history: playlist.history),
                ],
              ),
            ),
          ),
        ]),
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
          onPressed: playlist.status == PlaylistStatus.fetching ||
                  playlist.status == PlaylistStatus.checking
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
