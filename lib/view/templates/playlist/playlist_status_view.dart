import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/playlist_status.dart';
import 'package:yt_playlists_plus/controller/reorder_controller.dart';

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
      padding: const EdgeInsets.only(right: 10.0),
      child: ReorderController().canReorder
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
