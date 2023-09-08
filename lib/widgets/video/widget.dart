import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:yt_playlists_plus/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    Video video = Provider.of<Video>(context);

    return Card(
      shape: cardBorder(firstOfList: firstOfList, lastOfList: lastOfList),
      child: Ink(
        child: InkWell(
          onTap: showStatus
              ? video.onTap
              : () async {
                  await Clipboard.setData(ClipboardData(text: video.title));
                },
          onLongPress: showStatus
              ? () => video.onLongPress!(context)
              : () async {
                  await Clipboard.setData(ClipboardData(text: video.id));
                },
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
    );
  }
}
