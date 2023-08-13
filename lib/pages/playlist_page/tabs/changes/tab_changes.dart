import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/changes/changes_list.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/changes/pend_all.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/changes/status.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/changes/status_card.dart';

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
    final Set<Video> changes = (added.toList() + missing.toList()).toSet();

    Playlist playlist = Provider.of<Playlist>(context);
    return Column(
      children: [
        Padding(
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
                                video.function!();
                              }
                            }
                          },
              )
            ],
          ),
        ),
        const Divider(),
        const SizedBox(height: 16),
        playlist.status == PlaylistStatus.changed
            ? ChangesList(changes: changes)
            : ChangesCenterText(status: playlist.status)
      ],
    );
  }
}
