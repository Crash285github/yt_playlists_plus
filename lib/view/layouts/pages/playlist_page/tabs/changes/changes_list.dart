import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/video_controller.dart';
import 'package:yt_playlists_plus/view/bottom_padding.dart';
import 'package:yt_playlists_plus/view/templates/video/video_view.dart';

class ChangesList extends StatefulWidget {
  final Set<VideoController> changes;
  const ChangesList({
    super.key,
    required this.changes,
  });

  @override
  State<ChangesList> createState() => _ChangesListState();
}

class _ChangesListState extends State<ChangesList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    int index = 0;

    return Expanded(
        child: ListView(
      children: [
        ...widget.changes.map(
          (e) {
            index++;
            return ListenableProvider.value(
              value: e,
              child: VideoView(
                firstOfList: index == 1,
                lastOfList: index == widget.changes.length,
              ),
            );
          },
        ),
        const AdaptiveHeightBox(),
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
