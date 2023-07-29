import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/Playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class PlaylistPage extends StatelessWidget {
  final Playlist playlist;

  const PlaylistPage({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(playlist.title),
          centerTitle: true,
          actions: _appBarActions(context),
          bottom: const TabBar(
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
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListenableProvider.value(
              value: playlist,
              child: const ChangesTab(),
            ),
            MoreTab(playlist: playlist),
          ],
        ),
        floatingActionButton: IconButton(
          icon: const Icon(Icons.save),
          onPressed: () => Persistence().save(),
          iconSize: 30,
          tooltip: "Save",
        ),
      ),
    );
  }

  _appBarActions(BuildContext context) => [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () async {
                  await playlist.fetchVideos().drain();
                  playlist.check();
                },
                icon: const Icon(Icons.refresh_outlined),
              ),
              IconButton(
                onPressed: () {
                  Persistence().removePlaylist(playlist);
                  Persistence().save();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
      ];
}
