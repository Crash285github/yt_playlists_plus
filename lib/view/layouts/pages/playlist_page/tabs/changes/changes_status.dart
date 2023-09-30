import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/enums/playlist_status.dart';
import 'package:yt_playlists_plus/view/templates/playlist/playlist_progress_indicator.dart';

class ChangesStatus extends StatelessWidget {
  final PlaylistStatus status;
  final int progress;

  const ChangesStatus({
    super.key,
    required this.status,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    String message = "";
    switch (status) {
      case PlaylistStatus.downloading:
        message = "Downloading... $progress%";
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
        message = "Fetching... $progress%";
        break;
      case PlaylistStatus.saved:
        message = "Playlist saved.";
        break;
      default:
        message = "";
    }
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  )),
          if (status == PlaylistStatus.fetching ||
              status == PlaylistStatus.downloading) ...[
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 0.4,
              child: PlaylistProgressIndicator(
                progress: progress / 100,
                color: status.color,
              ),
            )
          ]
        ],
      ),
    );
  }
}
