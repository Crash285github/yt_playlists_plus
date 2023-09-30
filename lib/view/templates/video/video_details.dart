import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/extensions/hide_topic.dart';
import 'package:yt_playlists_plus/controller/video_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/hide_topics_controller.dart';

///Displays the `Video`'s [title] & [author]
class VideoDetails extends StatelessWidget {
  final VideoController video;

  const VideoDetails({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    bool hideTopics = Provider.of<HideTopicsController>(context).hideTopics;
    final ThemeData theme = Theme.of(context);

    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tooltip(
            message: video.title,
            child: Text(
              video.title,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            hideTopics ? video.author.hideTopic() : video.author,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall!
                .copyWith(color: theme.colorScheme.onSurface.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }
}
