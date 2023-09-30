import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/video_controller.dart';
import 'package:yt_playlists_plus/view/bottom_padding.dart';
import 'package:yt_playlists_plus/view/templates/video/video_view.dart';

class ChangesList extends StatelessWidget {
  final Set<VideoController> changes;
  const ChangesList({
    super.key,
    required this.changes,
  });

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return Expanded(
        child: ListView(
      children: [
        ...changes.map(
          (e) {
            index++;
            return ListenableProvider.value(
              value: e,
              child: VideoView(
                firstOfList: index == 1,
                lastOfList: index == changes.length,
              ),
            );
          },
        ),
        const BottomPadding(),
      ],
    ));
  }
}
