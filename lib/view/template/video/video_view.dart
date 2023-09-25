import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:yt_playlists_plus/services/popup_controller/popup_controller.dart';
import 'package:yt_playlists_plus/services/popup_controller/show_context_menu.dart';
import 'package:yt_playlists_plus/view/template/adatpive_gesture_detector.dart';
import 'package:yt_playlists_plus/view/abstract_list_widget.dart';
import 'package:yt_playlists_plus/view/template/thumbnail.dart';
import 'package:yt_playlists_plus/view/template/video/video_details.dart';
import 'package:yt_playlists_plus/view/template/video/video_status_view.dart';
import 'package:yt_playlists_plus/model/video/video.dart';

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
      onTrigger: (offset) => PopUpController().showContextMenu(
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
