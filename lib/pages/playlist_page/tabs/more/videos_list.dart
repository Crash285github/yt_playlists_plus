import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/more_top_row.dart';
import 'package:yt_playlists_plus/widgets/bottom_padding.dart';
import 'package:yt_playlists_plus/widgets/video/widget.dart';

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

    return ListView(
      children: [
        MoreTopRow(length: widget.videos.length),
        const Divider(),
        const SizedBox(height: 16),
        ...widget.videos.map((e) {
          index++;
          return ListenableProvider.value(
              value: e,
              child: VideoWidget(
                firstOfList: index == 1,
                lastOfList: index == widget.videos.length,
                isInteractable: false,
              ));
        }),
        const BottomPadding(androidHeight: 230, windowsHeight: 200),
      ],
    );
  }
}
