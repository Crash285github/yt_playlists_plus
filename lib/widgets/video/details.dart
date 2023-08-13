import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';

class VideoDetails extends StatelessWidget {
  final Video video;
  const VideoDetails({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //? title
          Tooltip(
            message: video.title,
            child: Text(
              video.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          const SizedBox(height: 7),
          //? author
          Text(
            video.author,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: ApplicationTheme.get() == ApplicationTheme.light
                      ? Colors.grey[700]
                      : Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
}
