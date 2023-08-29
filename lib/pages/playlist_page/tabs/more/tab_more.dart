import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/empty.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/more_top_row.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/planned/sheet_mobile.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/videos_list.dart';

class MoreTab extends StatelessWidget {
  final Playlist playlist;

  const MoreTab({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        Column(
          children: [
            MoreTopRow(playlist: playlist),
            const Divider(),
            playlist.videos.isEmpty
                ? const EmptyVideos()
                : VideosList(videos: playlist.videos),
          ],
        ),
        Platform.isAndroid
            ? PlannedSheetMobile(playlist: playlist)
            : const SizedBox.shrink()
      ]),
    );
  }
}
