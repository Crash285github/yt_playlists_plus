import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yt_playlists_plus/model/popup_manager.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:yt_playlists_plus/constants.dart';
import 'package:yt_playlists_plus/widgets/adatpive_gesture_detector.dart';
import 'package:yt_playlists_plus/widgets/icard.dart';
import 'package:yt_playlists_plus/widgets/thumbnail.dart';
import 'package:yt_playlists_plus/widgets/video/details.dart';
import 'package:yt_playlists_plus/widgets/video/status.dart';
import 'package:yt_playlists_plus/model/video/video.dart';

///Shows a single video
class VideoWidget extends ICardWidget {
  final bool showStatus;

  const VideoWidget({
    super.key,
    super.firstOfList = false,
    super.lastOfList = false,
    this.showStatus = true,
  });

  RelativeRect positionFromOffset(
      {required BuildContext context, required Offset offset}) {
    return RelativeRect.fromLTRB(
        offset.dx, offset.dy, MediaQuery.of(context).size.width - offset.dx, 0);
  }

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
      const PopupMenuDivider(),
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
        const PopupMenuDivider(),
        PopupMenuItem(
          child: const Center(child: Text('Add to planned')),
          onTap: () => video.statusFunction!(context),
        ),
      ],
    ];

    return AdaptiveGestureDetector(
      onLongOrSecondaryTap: (offset) => PopUpManager.showContextMenu(
          context: context, offset: offset, items: contextMenuItems),
      child: Card(
        shape: cardBorder(firstOfList: firstOfList, lastOfList: lastOfList),
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
                          thumbnailUrl: video.thumbnailUrl,
                          largeRadius: 13.0,
                          smallRadius: 4.0,
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
