import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';
import '../model/video/video.dart';

///Shows a single video with a configurable `onTap` function
class VideoWidget extends StatelessWidget {
  const VideoWidget({
    super.key,
    required this.isInteractable,
  });

  ///Whether the Widget can be tapped
  ///
  ///If false, the Status Icon doesn't show
  final bool isInteractable;

  @override
  Widget build(BuildContext context) {
    Video video = Provider.of<Video>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: isInteractable ? video.function : null,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Flexible(
                child: Row(
                  children: [
                    thumbnail(video.thumbnailUrl),
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
      );

  thumbnail(String thumbnailUrl) => Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: NetworkImage(
                thumbnailUrl,
              ),
              fit: BoxFit.cover,
            ),
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
