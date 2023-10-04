import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/enums/playlist_status.dart';
import 'package:yt_playlists_plus/controller/video_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/changes/save_button.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/changes/changes_list.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/changes/changes_info.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/changes/changes_status.dart';

class ChangesTab extends StatelessWidget {
  final Set<VideoController> added;
  final Set<VideoController> missing;

  const ChangesTab({
    super.key,
    required this.added,
    required this.missing,
  });

  @override
  Widget build(BuildContext context) {
    PlaylistController playlist = Provider.of<PlaylistController>(context);

    added.addAll(missing);
    final Set<VideoController> changes = added;

    return Scaffold(
      body: Column(
        children: [
          ChangesInfo(
            changes: changes,
            playlist: playlist,
          ),
          playlist.status == PlaylistStatus.changed
              ? ChangesList(changes: changes)
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
