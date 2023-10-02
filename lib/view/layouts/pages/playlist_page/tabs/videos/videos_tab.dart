import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/videos/empty_videos.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/videos/planned/planned_button.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/videos/videos_info.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/videos/planned/planned_sheet_mobile.dart';
import 'package:yt_playlists_plus/view/templates/video/video_view.dart';

class VideosTab extends StatefulWidget {
  final PlaylistController playlist;

  const VideosTab({
    super.key,
    required this.playlist,
  });

  @override
  State<VideosTab> createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    int index = 0;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: 50),
              ...widget.playlist.videos.isEmpty
                  ? [const EmptyVideos()]
                  : widget.playlist.videos.map((e) {
                      index++;
                      return ListenableProvider.value(
                        value: e,
                        child: VideoView(
                          firstOfList: index == 1,
                          lastOfList: index == widget.playlist.videos.length,
                          showStatus: false,
                        ),
                      );
                    }),
              VideosInfo(playlist: widget.playlist)
            ],
          ),
          if (Platform.isAndroid) PlannedSheetMobile(playlist: widget.playlist)
        ],
      ),
      floatingActionButton: PlannedButton(controller: widget.playlist),
    );
  }
}
