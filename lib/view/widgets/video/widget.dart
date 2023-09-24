import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yt_playlists_plus/services/popup_service.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:yt_playlists_plus/view/widgets/adatpive_gesture_detector.dart';
import 'package:yt_playlists_plus/view/widgets/abstract_list_widget.dart';
import 'package:yt_playlists_plus/view/widgets/thumbnail.dart';
import 'package:yt_playlists_plus/view/widgets/video/details.dart';
import 'package:yt_playlists_plus/view/widgets/video/status.dart';
import 'package:yt_playlists_plus/model/video/video.dart';

///Shows a single video
class VideoWidget extends ListWidget {
  final bool showStatus;

  const VideoWidget({
    super.key,
    super.firstOfList = false,
    super.lastOfList = false,
    this.showStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    Video video = Provider.of<Video>(context);

    final List<PopupMenuEntry<dynamic>> contextMenuItems = [
      PopupMenuItem(
        child: const Center(child: Text("Open link")),
        onTap: () async {
          await launchUrl(Uri.parse("https://youtube.com/watch?v=${video.id}"));
        },
      ),
      const PopupMenuDivider(height: 0),
      PopupMenuItem(
        child: const Center(child: Text("Copy title")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: video.title));
        },
      ),
      PopupMenuItem(
        child: const Center(child: Text("Copy id")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: video.id));
        },
      ),
      PopupMenuItem(
        child: const Center(child: Text("Copy link")),
        onTap: () async {
          await Clipboard.setData(
              ClipboardData(text: "www.youtube.com/watch?v=${video.id}"));
        },
      ),
      if (video.status == VideoStatus.missing) ...[
        const PopupMenuDivider(height: 0),
        PopupMenuItem(
          child: const Center(child: Text('Add to planned')),
          onTap: () => video.statusFunction!(context),
        ),
      ],
    ];

    return AdaptiveGestureDetector(
      onTrigger: (offset) => PopUpService.showContextMenu(
          context: context, offset: offset, items: contextMenuItems),
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
                    ? VideoStatusWidget(status: video.status)
                    : const SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
