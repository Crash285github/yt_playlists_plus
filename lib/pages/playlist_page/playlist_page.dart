import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/playlist_page/appbar_actions.dart';
import 'package:yt_playlists_plus/pages/playlist_page/body.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabbar.dart';

class PlaylistPage extends StatelessWidget {
  final Function() onDelete;
  const PlaylistPage({
    super.key,
    required this.onDelete,
  });

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
          actions: AppBarActions.build(
            context: context,
            playlist: playlist,
            onDelete: onDelete,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
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
