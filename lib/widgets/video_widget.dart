import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';
import 'package:yt_playlists_plus/persistence/theme_constants.dart%20';
import 'package:yt_playlists_plus/widgets/icard.dart';
import '../model/video/video.dart';

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
                      padding: const EdgeInsets.fromLTRB(3, 3, 0, 3),
                      child: thumbnail(
                        thumbnailUrl: video.thumbnailUrl,
                        firstOfList: firstOfList,
                        lastOfList: lastOfList,
                      ),
                    ),
                    details(context, video),
                  ],
                ),
              ),
              isInteractable ? status(video.status) : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

extension _VideoWidgetExtension on VideoWidget {
  details(BuildContext context, Video video) => Flexible(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Tooltip(
                message: video.title,
                child: Text(
                  video.title,
                  style: Theme.of(context).textTheme.labelLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                video.author,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: ApplicationTheme.get() == ApplicationTheme.light
                          ? Colors.grey[700]
                          : Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      );

  thumbnail(
          {required String thumbnailUrl,
          bool firstOfList = false,
          bool lastOfList = false}) =>
      Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: firstOfList && lastOfList
              ? const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(4),
                  bottomLeft: Radius.circular(13),
                  bottomRight: Radius.circular(4),
                )
              : firstOfList
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(13),
                      topRight: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    )
                  : lastOfList
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(13),
                          bottomRight: Radius.circular(4),
                        )
                      : const BorderRadius.all(Radius.circular(4)),
          image: DecorationImage(
            image: NetworkImage(
              thumbnailUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
      );

  status(VideoStatus status) {
    if (status == VideoStatus.hidden) return const SizedBox.shrink();
    Widget icon = Tooltip(
        message: status.displayName,
        child: Icon(
          status.icon,
          color: status.color,
        ));

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: icon,
    );
  }
}
