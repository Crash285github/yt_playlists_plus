import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/enums/playlist_status.dart';
import 'package:yt_playlists_plus/controller/video_controller.dart';
import 'package:yt_playlists_plus/enums/video_status.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/changes/pend_all_button.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/changes/status_card.dart';

class ChangesInfo extends StatelessWidget {
  final Set<VideoController> changes;
  final PlaylistController playlist;

  const ChangesInfo({
    super.key,
    required this.changes,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatusCard(status: playlist.status),
          PendAllButton(
            onPressed:
                changes.isEmpty || playlist.status != PlaylistStatus.changed
                    ? null
                    : () {
                        for (var video in changes) {
                          if (video.status != VideoStatus.pending) {
                            video.onTap!();
                          }
                        }
                      },
          )
        ],
      ),
    );
  }
}
