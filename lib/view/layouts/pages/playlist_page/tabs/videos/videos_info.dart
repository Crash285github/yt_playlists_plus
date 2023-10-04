import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';

class VideosInfo extends StatefulWidget {
  final PlaylistController playlist;

  const VideosInfo({
    super.key,
    required this.playlist,
  });

  @override
  State<VideosInfo> createState() => _VideosInfoState();
}

class _VideosInfoState extends State<VideosInfo> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color textColor =
        Theme.of(context).colorScheme.onBackground.withOpacity(0.5);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        shadowColor: Colors.transparent,
        child: ExpansionTile(
            shape: const Border(),
            collapsedShape: const Border(),
            title: const Text("Details"),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Author: ${widget.playlist.author.substring(3)}",
                              style: textTheme.bodyLarge!
                                  .copyWith(color: textColor),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Videos: ${widget.playlist.videos.length}",
                              style: textTheme.bodyLarge!
                                  .copyWith(color: textColor),
                            ),
                            Text(
                              "History: ${widget.playlist.history.length}",
                              style: textTheme.bodyLarge!
                                  .copyWith(color: textColor),
                            ),
                            Text(
                              "Planned: ${widget.playlist.planned.length}",
                              style: textTheme.bodyLarge!
                                  .copyWith(color: textColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
