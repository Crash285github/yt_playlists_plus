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

  const VideoView({
    super.key,
    super.firstOfList = false,
    super.lastOfList = false,
    this.showStatus = true,
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
            child: Row(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3, 3, 10, 3),
                        child: ThumbnailImage(
                          url: video.thumbnailUrl,
                          strongCorner: 13.0,
                          weakCorner: 4.0,
                          size: 70.0,
                          firstOfList: firstOfList,
                          lastOfList: lastOfList,
                        ),
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
          ),
        ),
      ),
    );
  }
}
