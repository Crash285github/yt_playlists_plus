import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/empty.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/planned/planned_panel.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/videos_list.dart';

class MoreTab extends StatelessWidget {
  final Playlist playlist;
  MoreTab({super.key, required this.playlist});

  final PanelController _controller = PanelController();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      color: Colors.transparent,
      minHeight: 95,
      parallaxEnabled: true,
      parallaxOffset: 0.2,
      backdropTapClosesPanel: true,
      backdropOpacity: 0.5,
      backdropColor: Colors.black,
      backdropEnabled: true,
      boxShadow: const [],
      controller: _controller,
      panelBuilder: (scrollController) {
        return PlannedPanel(
          planned: playlist.planned,
          panelController: _controller,
          scrollController: scrollController,
        );
      },
      body: playlist.videos.isEmpty
          ? const EmptyVideos()
          : VideosList(videos: playlist.videos),
    );
  }
}
