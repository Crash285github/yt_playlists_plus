import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/group_history_service.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:yt_playlists_plus/extensions/format_date_time.dart';

class VideoHistoryDetails extends StatelessWidget {
  final String title, author;
  final DateTime time;

  const VideoHistoryDetails({
    super.key,
    required this.title,
    required this.author,
    required this.time,
  });

  final duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    bool groupTime = Provider.of<GroupHistoryService>(context).groupHistory;
    return Flexible(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Tooltip(
          message: title,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Row(children: [
          Text(author,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.grey)),
          IgnorePointer(
            ignoring: groupTime,
            child: AnimatedSlide(
              duration: duration,
              curve: Curves.decelerate,
              offset: groupTime ? const Offset(0.5, 0) : const Offset(0, 0),
              child: AnimatedOpacity(
                opacity: groupTime ? 0 : 1,
                duration: duration,
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
