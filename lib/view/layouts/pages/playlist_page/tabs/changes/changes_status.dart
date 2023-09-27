import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';

class ChangesStatus extends StatelessWidget {
  final PlaylistStatus status;
  final int fetchProgress;
  final int downloadProgress;

  const ChangesStatus({
    super.key,
    required this.status,
    required this.fetchProgress,
    required this.downloadProgress,
  });

  @override
  Widget build(BuildContext context) {
    String message = "";
    switch (status) {
      case PlaylistStatus.downloading:
        message = "Downloading... $downloadProgress%";
        break;
      case PlaylistStatus.downloaded:
        message = "Just downloaded.";
        break;
      case PlaylistStatus.notFound:
        message = "Hmm... that's not good.";
        break;
      case PlaylistStatus.unChanged:
        message = "No changes. That's good.";
        break;
      case PlaylistStatus.unChecked:
        message = "Press the refresh button to check.";
        break;
      case PlaylistStatus.fetching:
        message = "Fetching... $fetchProgress%";
        break;
      case PlaylistStatus.saved:
        message = "Playlist saved.";
        break;
      default:
        message = "";
    }
    return Expanded(
      child: Center(
        child: Text(message,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                )),
      ),
    );
  }
}
