import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/pages/playlist_page/video_list.dart';
import '../../model/playlist/playlist.dart';
import '../../model/video/video.dart';

class ChangesTab extends StatelessWidget {
  final Set<Video> added;
  final Set<Video> missing;

  const ChangesTab({super.key, required this.added, required this.missing});

  @override
  Widget build(BuildContext context) {
    Playlist playlist = Provider.of<Playlist>(context);
    return ListView(
      children: [
        Text(
          'Status: ${playlist.status.displayName}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: playlist.status.color,
            fontSize: 20,
          ),
        ),
        playlist.status == PlaylistStatus.changed
            ? Column(
                children: [
                  VideoList(
                    title: "Added Videos:",
                    videos: added,
                  ),
                  VideoList(
                    title: "Missing Videos:",
                    videos: missing,
                  ),
                ],
              )
            : const Text(""),
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

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("WIP"),
    );
  }
}
