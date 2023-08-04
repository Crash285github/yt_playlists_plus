import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
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
          actions: [AppBarActions(playlist: playlist)],
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
            ChangesTab(
                added: playlist.getAdded(), missing: playlist.getMissing()),
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
}

class AppBarActions extends StatefulWidget {
  final Playlist playlist;
  const AppBarActions({super.key, required this.playlist});

  @override
  State<AppBarActions> createState() => _AppBarActionsState();
}

class _AppBarActionsState extends State<AppBarActions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          tooltip: "Refresh",
          icon: const Icon(Icons.refresh_outlined),
          onPressed: widget.playlist.status == PlaylistStatus.fetching
              ? null
              : () async {
                  await widget.playlist.fetchVideos().drain();
                  widget.playlist.check();
                },
        ),
        IconButton(
          onPressed: () {
            Persistence.removePlaylist(widget.playlist);
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
