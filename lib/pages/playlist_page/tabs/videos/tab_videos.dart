import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/videos/empty.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/videos/videos_top_row.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/videos/planned/sheet_mobile.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/videos/videos_list.dart';

class VideosTab extends StatelessWidget {
  final Playlist playlist;

  const VideosTab({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Column(
            children: [
              VideosTopRow(playlist: playlist),
              const Divider(),
              playlist.videos.isEmpty
                  ? const EmptyVideos()
                  : VideosList(videos: playlist.videos),
            ],
          ),
          if (Platform.isAndroid) PlannedSheetMobile(playlist: playlist)
        ],
      ),
    );
  }
}
