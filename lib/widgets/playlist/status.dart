import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class PlaylistStatusWidget extends StatelessWidget {
  final PlaylistStatus status;
  const PlaylistStatusWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Widget icon = Tooltip(
      message: status.displayName,
      child: Icon(
        status.icon,
        color: status.color,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Persistence.canReorder
          ? const SizedBox.shrink()
          : Column(
              children: [
                const SizedBox(height: 40),
                icon,
              ],
            ),
    );
  }
}
