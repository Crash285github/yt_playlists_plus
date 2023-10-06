import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/playlist_status.dart';

class StatusCard extends StatelessWidget {
  final PlaylistStatus status;
  const StatusCard({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.transparent,
      color: Theme.of(context).cardColor,
      surfaceTintColor: status.color,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          'Status: ${status.displayName}',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: status.color,
              ),
        ),
      ),
    );
  }
}
