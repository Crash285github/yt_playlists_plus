import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class VideoDetails extends StatelessWidget {
  final Video video;
  const VideoDetails({
    super.key,
    required this.video,
  });

  String hideTopic(String author) {
    if (!Persistence.hideTopics) return author;
    return author.endsWith(" - Topic")
        ? author.substring(0, author.length - 8)
        : author;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);

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
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 7),
          //? author
          Text(
            hideTopic(video.author),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
          ),
        ],
      ),
    );
  }
}
