import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/config.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/history_limit_controller.dart';

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
  int minWithNull(int first, int? second) {
    if (second == null) return first;
    return min(first, second);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!;
    final Color textColor =
        Theme.of(context).colorScheme.onBackground.withOpacity(0.5);

    Provider.of<HistoryLimitController>(context).limit;

    return Padding(
      padding: const EdgeInsets.all(AppConfig.spacing),
      child: Card(
        color: Theme.of(context).cardColor.withOpacity(0.4),
        shadowColor: Colors.transparent,
        child: ExpansionTile(
            expandedAlignment: Alignment.center,
            shape: const Border(),
            collapsedShape: const Border(),
            title: const Text("More"),
            children: [
              Padding(
                padding: const EdgeInsets.all(AppConfig.spacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Author: ${widget.playlist.author.substring(3)}",
                                style: textStyle.copyWith(color: textColor),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Videos: ${widget.playlist.videos.length}",
                              style: textStyle.copyWith(color: textColor),
                            ),
                            Text(
                              "History: ${minWithNull(widget.playlist.history.length, HistoryLimitController().limit)}",
                              style: textStyle.copyWith(color: textColor),
                            ),
                            Text(
                              "Planned: ${widget.playlist.planned.length}",
                              style: textStyle.copyWith(color: textColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Text(
                      "Description:",
                      style: textStyle.copyWith(color: textColor),
                    ),
                    Text(
                      widget.playlist.description,
                      style: textStyle.copyWith(color: textColor),
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}
