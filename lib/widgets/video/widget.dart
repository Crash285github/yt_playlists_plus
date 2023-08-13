import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/persistence/theme_constants.dart%20';
import 'package:yt_playlists_plus/widgets/icard.dart';
import 'package:yt_playlists_plus/widgets/thumbnail.dart';
import 'package:yt_playlists_plus/widgets/video/details.dart';
import 'package:yt_playlists_plus/widgets/video/status.dart';
import '../../model/video/video.dart';

///Shows a single video with a configurable `onTap` function
class VideoWidget extends ICardWidget {
  ///Whether the Widget can be tapped
  ///
  ///If false, the Status Icon doesn't show
  final bool isInteractable;

  const VideoWidget({
    super.key,
    super.firstOfList = false,
    super.lastOfList = false,
    this.isInteractable = true,
  });

  @override
  Widget build(BuildContext context) {
    Video video = Provider.of<Video>(context);

    return Card(
      shape: cardBorder(firstOfList: firstOfList, lastOfList: lastOfList),
      child: Ink(
        child: InkWell(
          onTap: isInteractable ? video.function : null,
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
              isInteractable
                  ? VideoStatusWidget(status: video.status)
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
