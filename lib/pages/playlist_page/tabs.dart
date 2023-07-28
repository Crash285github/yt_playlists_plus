import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/pages/playlist_page/widgets.dart';

import '../../model/video.dart';

class ChangesTab extends StatelessWidget {
  final Set<Video> videos;
  const ChangesTab({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        VideoList(
          title: "Added Videos:",
          videos: {},
        ),
        VideoList(
          title: "Missing Videos:",
          videos: {},
        ),
      ],
    );
  }
}

class MoreTab extends StatelessWidget {
  final Set<Video> videos;
  const MoreTab({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const VideoList(title: "Planned Videos:", videos: {}),
        VideoList(
          title: "All Videos:",
          videos: videos,
        ),
      ],
    );
  }
}
