import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/enums/video_status.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/services/popup_service/show_context_menu.dart';
import 'package:yt_playlists_plus/view/templates/adatpive_gesture_detector.dart';
import 'package:yt_playlists_plus/view/abstract_list_widget.dart';
import 'package:yt_playlists_plus/view/templates/thumbnail.dart';
import 'package:yt_playlists_plus/view/templates/video/video_details.dart';
import 'package:yt_playlists_plus/view/templates/video/video_status_view.dart';
import 'package:yt_playlists_plus/controller/video_controller.dart';

///Shows a single video
class VideoView extends ListWidget {
  final bool showStatus;
  final int? index;

  const VideoView({
    super.key,
    super.firstOfList = false,
    super.lastOfList = false,
    this.showStatus = true,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    VideoController video = Provider.of<VideoController>(context);

    return AdaptiveGestureDetector(
      onTrigger: (offset) => PopUpService()
          .showContextMenu(context: context, offset: offset, video: video),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: radiusBuilder()),
        child: Ink(
          child: InkWell(
            onTap: showStatus ? video.onTap : null,
            child: _Content(
              video: video,
              firstOfList: firstOfList,
              lastOfList: lastOfList,
              showStatus: showStatus,
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.video,
    required this.firstOfList,
    required this.lastOfList,
    required this.showStatus,
    this.index,
  });

  final VideoController video;
  final bool firstOfList;
  final bool lastOfList;
  final bool showStatus;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (index != null)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 2, right: 5),
              child: Text(
                "#$index",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.2)),
              ),
            ),
          ),
        Row(
          children: [
            Flexible(
              child: Row(
                children: [
                  ThumbnailImage(
                    url: video.thumbnailUrl,
                    firstOfList: firstOfList,
                    lastOfList: lastOfList,
                    size: 70.0,
                  ),
                  VideoDetails(video: video),
                ],
              ),
            ),
            showStatus || video.status != VideoStatus.normal
                ? VideoStatusView(status: video.status)
                : const SizedBox(width: 10),
          ],
        ),
      ],
    );
  }
}
