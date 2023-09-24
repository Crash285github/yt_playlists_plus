import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/view/pages/playlist_page/tabs/videos/planned/planned_panel.dart';

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
                showModalBottomSheet<void>(
                  context: context,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  builder: (context) => PlannedPanel(
                    planned: playlist.planned,
                    scrollController: ScrollController(),
                    onHandleTapped: null,
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
