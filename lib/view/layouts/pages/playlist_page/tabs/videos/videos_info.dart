import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/view/bottom_padding.dart';

class VideosInfo extends StatelessWidget {
  final PlaylistController playlist;

  const VideosInfo({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color textColor =
        Theme.of(context).colorScheme.onBackground.withOpacity(0.5);
    return Center(
        child: Column(
      children: [
        Text(
          "Playlist information",
          style: textTheme.titleLarge!.copyWith(color: textColor),
        ),
        const Divider(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Author: ${playlist.author.substring(3)}",
                  style: textTheme.bodyLarge!.copyWith(color: textColor),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Videos: ${playlist.videos.length}",
                  style: textTheme.bodyLarge!.copyWith(color: textColor),
                ),
                Text(
                  "History: ${playlist.history.length}",
                  style: textTheme.bodyLarge!.copyWith(color: textColor),
                ),
                Text(
                  "Planned: ${playlist.history.length}",
                  style: textTheme.bodyLarge!.copyWith(color: textColor),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.3)
      ],
    ));
  }
}
