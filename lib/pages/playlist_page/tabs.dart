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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Status: ${playlist.status.displayName}',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: playlist.status.color),
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
        const SizedBox(height: 100),
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
        Text(playlist.planned.length.toString()),
        VideoList(
          title: "All Videos:",
          videos: playlist.videos,
        ),
        const SizedBox(height: 100),
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
