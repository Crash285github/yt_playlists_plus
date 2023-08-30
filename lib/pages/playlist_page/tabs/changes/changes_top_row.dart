import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/changes/pend_all.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/changes/status_card.dart';

class ChangesTopRow extends StatelessWidget {
  final Set<Video> changes;
  final Playlist playlist;

  const ChangesTopRow({
    super.key,
    required this.changes,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
