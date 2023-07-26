import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/widgets/widgets_export.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          customSliverAppBar("playlistTitle"),
          SliverList(
            delegate: SliverChildListDelegate([
              const Placeholder(
                fallbackHeight: 1000,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
