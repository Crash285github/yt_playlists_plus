import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs.dart';
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
          actions: _appBarActions(context, playlist),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.change_circle_outlined),
                    SizedBox(width: 10),
                    Text("Changes"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.more_horiz),
                    SizedBox(width: 10),
                    Text("More"),
                  ],
                ),
              ),
              Tab(
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
          ),
        ),
        body: TabBarView(
          children: [
            ListenableProvider.value(
              value: playlist,
              child: ChangesTab(
                  added: playlist.getAdded(), missing: playlist.getMissing()),
            ),
            MoreTab(playlist: playlist),
            const HistoryTab(),
          ],
        ),
        floatingActionButton: IconButton(
          icon: const Icon(Icons.save),
          onPressed: () => Persistence.save(),
          iconSize: 30,
          tooltip: "Save",
        ),
      ),
    );
  }

  _appBarActions(BuildContext context, Playlist playlist) => [
        Row(
          children: [
            IconButton(
              onPressed: () async {
                await playlist.fetchVideos().drain();
                playlist.check();
              },
              icon: const Icon(Icons.refresh_outlined),
              tooltip: "Refresh",
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
        ),
      ];
}
