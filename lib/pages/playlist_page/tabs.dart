import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/pages/playlist_page/widgets.dart';
import '../../model/Playlist/playlist.dart';

class ChangesTab extends StatelessWidget {
  final Playlist playlist;
  const ChangesTab({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        VideoList(
          title: "Added Videos:",
          videos: playlist.getAdded(),
        ),
        VideoList(
          title: "Missing Videos:",
          videos: playlist.getMissing(),
        ),
      ],
    );
  }
}

class MoreTab extends StatelessWidget {
  final Playlist playlist;
  const MoreTab({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const VideoList(title: "Planned Videos:", videos: {}),
        VideoList(
          title: "All Videos:",
          videos: playlist.videos,
        ),
      ],
    );
  }
}
