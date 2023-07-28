import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist.dart';
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
            _videoList("Added videos:"),
            _videoList("Missing videos:"),
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
                onPressed: () {},
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

  _videoList(String title) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black54,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //title
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              //videos
            ),
          ],
        ),
      );
}
