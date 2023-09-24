import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/view/widgets/bottom_padding.dart';
import 'package:yt_playlists_plus/view/widgets/video/widget.dart';

class ChangesList extends StatelessWidget {
  final Set<Video> changes;
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
              child: VideoWidget(
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