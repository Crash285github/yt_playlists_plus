import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/videos/planned/planned_panel.dart';
import 'package:yt_playlists_plus/constants.dart';

class VideosTopRow extends StatelessWidget {
  final Playlist playlist;
  const VideosTopRow({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Videos: (${playlist.videos.length})",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (Platform.isWindows)
            TextButton(
              onPressed: () {
                Scaffold.of(context).showBottomSheet<void>(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5),
                  (context) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black54, Colors.transparent],
                          stops: [0.0, 0.8],
                          transform: GradientRotation(-pi / 2)),
                    ),
                    child: PlannedPanel(
                      planned: playlist.planned,
                      scrollController: ScrollController(),
                      onHandleTapped: null,
                    ),
                  ),
                );
              },
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("Planned"), Icon(Icons.draw_outlined)],
              ),
            )
        ],
      ),
    );
  }
}
