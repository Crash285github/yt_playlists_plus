import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';

///Displays the `Playlist`'s [title] & [author]
class PlaylistDetails extends StatelessWidget {
  final Playlist playlist;

  const PlaylistDetails({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Tooltip(
            message: playlist.title,
            child: Text(
              playlist.title,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            playlist.author,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall!.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
