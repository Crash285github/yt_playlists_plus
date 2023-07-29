import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/pages/playlist_page/widgets.dart';
import '../../model/playlist/playlist.dart';

class ChangesTab extends StatelessWidget {
  const ChangesTab({super.key});

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
                    videos: playlist.getAdded(),
                  ),
                  VideoList(
                    title: "Missing Videos:",
                    videos: playlist.getMissing(),
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
