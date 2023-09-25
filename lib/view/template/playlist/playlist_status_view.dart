import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/services/reorder_service.dart';

///Displays the `Playlist`'s [status]
class PlaylistStatusView extends StatelessWidget {
  final PlaylistStatus status;

  const PlaylistStatusView({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ReorderService().canReorder
          ? const SizedBox.shrink()
          : Column(
              children: [
                const SizedBox(height: 40),
                Tooltip(
                  message: status.displayName,
                  child: Icon(
                    status.icon,
                    color: status.color,
                  ),
                ),
              ],
            ),
    );
  }
}
