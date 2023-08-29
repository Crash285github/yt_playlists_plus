import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/planned/planned_panel.dart';

class MoreTopRow extends StatelessWidget {
  final Playlist playlist;
  const MoreTopRow({
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
          Platform.isWindows
              ? TextButton(
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    enableDrag: false,
                    builder: (context) => PlannedPanel(
                      planned: playlist.planned,
                      scrollController: ScrollController(),
                      onHandleTapped: null,
                    ),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Planned"), Icon(Icons.draw_outlined)],
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
