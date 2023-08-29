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
    final MoreTopRow topRow = MoreTopRow(playlist: playlist);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        playlist.videos.isEmpty
            ? EmptyVideos(topRow: topRow)
            : VideosList(videos: playlist.videos, topRow: topRow),
        Platform.isAndroid
            ? PlannedSheetMobile(playlist: playlist)
            : const SizedBox.shrink()
      ]),
    );
  }
}
