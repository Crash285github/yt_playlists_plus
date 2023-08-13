import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';

class ChangesCenterText extends StatelessWidget {
  final PlaylistStatus status;
  const ChangesCenterText({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    String message = "";
    switch (status) {
      case PlaylistStatus.downloaded:
        message = "Just downloaded.";
        break;
      case PlaylistStatus.notFound:
        message = "Hmm... that's not good.";
        break;
      case PlaylistStatus.unChanged:
        message = "No changes. That's good.";
        break;
      default:
        message = "";
    }
    return Expanded(
      child: Center(
        child: Text(message,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.grey)),
      ),
    );
  }
}
