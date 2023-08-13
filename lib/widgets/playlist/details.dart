import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';

class PlaylistDetails extends StatelessWidget {
  final Playlist playlist;
  const PlaylistDetails({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //? title
          Tooltip(
            message: playlist.title,
            child: Text(
              playlist.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 10),
          //? author
          Text(
            playlist.author,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: ApplicationTheme.get() == ApplicationTheme.light
                      ? Colors.grey[700]
                      : Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
}
