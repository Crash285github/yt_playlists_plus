import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/changes/save_button.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/changes/changes_list.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/changes/changes_info.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/changes/changes_status.dart';

class ChangesTab extends StatelessWidget {
  final Set<Video> added;
  final Set<Video> missing;

  const ChangesTab({
    super.key,
    required this.added,
    required this.missing,
  });

  @override
  Widget build(BuildContext context) {
    Playlist playlist = Provider.of<Playlist>(context);
    return Scaffold(
      body: Column(
        children: [
          ChangesInfo(
            changes: (added.toList() + missing.toList()).toSet(),
            playlist: playlist,
          ),
          const Divider(),
          playlist.status == PlaylistStatus.changed
              ? ChangesList(
                  changes: (added.toList() + missing.toList()).toSet())
              : ChangesStatus(
                  status: playlist.status,
                  progress: playlist.progress,
                )
        ],
      ),
      floatingActionButton:
          playlist.modified == 0 ? null : SaveButton(playlist: playlist),
      backgroundColor: Colors.transparent,
    );
  }
}
