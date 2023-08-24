import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/empty.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/planned/planned_panel.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/videos_list.dart';

class MoreTab extends StatelessWidget {
  final Playlist playlist;
  const MoreTab({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        playlist.videos.isEmpty
            ? const EmptyVideos()
            : VideosList(videos: playlist.videos),
        DraggableScrollableSheet(
          initialChildSize: 0.2,
          minChildSize: 0.05,
          maxChildSize: 0.7,
          snap: true,
          snapSizes: const [0.2],
          builder: (BuildContext context, ScrollController scrollController) {
            return PlannedPanel(
              planned: playlist.planned,
              scrollController: scrollController,
            );
          },
        ),
      ]),
    );
  }
}
