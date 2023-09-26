import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/view/bottom_padding.dart';
import 'package:yt_playlists_plus/view/templates/video/video_view.dart';

class VideosList extends StatefulWidget {
  final Set<Video> videos;
  const VideosList({
    super.key,
    required this.videos,
  });

  @override
  State<VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<VideosList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    int index = 0;

    return Expanded(
      child: ListView(
        children: [
          ...widget.videos.map(
            (e) {
              index++;
              return ListenableProvider.value(
                value: e,
                child: VideoView(
                  firstOfList: index == 1,
                  lastOfList: index == widget.videos.length,
                  showStatus: false,
                ),
              );
            },
          ),
          const BottomPadding(androidHeight: 50, windowsHeight: 10),
        ],
      ),
    );
  }
}