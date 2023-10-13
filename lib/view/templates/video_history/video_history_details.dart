import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/config.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/group_history_controller.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:yt_playlists_plus/controller/settings_controllers/hide_topics_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/theme_controller.dart';
import 'package:yt_playlists_plus/extensions/format_date_time.dart';
import 'package:yt_playlists_plus/extensions/hide_topic.dart';

class VideoHistoryDetails extends StatelessWidget {
  final String title, author;
  final DateTime time;
  final Color amoledColor;

  const VideoHistoryDetails({
    super.key,
    required this.title,
    required this.author,
    required this.time,
    required this.amoledColor,
  });

  final _duration = AppConfig.animationDuration;

  @override
  Widget build(BuildContext context) {
    bool groupTime = Provider.of<GroupHistoryController>(context).groupHistory;
    bool hideTopic = Provider.of<HideTopicsController>(context).hideTopics;

    return Flexible(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Tooltip(
          message: title,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: ThemeController().isAmoled
                    ? amoledColor
                    : Theme.of(context).colorScheme.onBackground),
          ),
        ),
        Row(children: [
          Text(hideTopic ? author.hideTopic() : author,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey)),
          IgnorePointer(
            ignoring: groupTime,
            child: AnimatedSlide(
              duration: _duration,
              curve: Curves.decelerate,
              offset: groupTime ? const Offset(0.5, 0) : const Offset(0, 0),
              child: AnimatedOpacity(
                opacity: groupTime ? 0 : 1,
                duration: _duration,
                curve: Curves.decelerate,
                child: Tooltip(
                  message: time.formatted(),
                  child: Text(" • ${timeago.format(time)}",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.grey)),
                ),
              ),
            ),
          ),
        ])
      ]),
    );
  }
}
