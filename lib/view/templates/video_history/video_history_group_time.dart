import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/config.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/group_history_controller.dart';
import 'package:yt_playlists_plus/extensions/format_date_time.dart';

class VideoHistoryGroupTime extends StatelessWidget {
  final DateTime time;
  const VideoHistoryGroupTime({
    super.key,
    required this.time,
  });

  final _duration = AppConfig.animationDuration;

  @override
  Widget build(BuildContext context) {
    bool groupTime = Provider.of<GroupHistoryController>(context).groupHistory;

    return AnimatedContainer(
      height: groupTime ? 25 : 0,
      duration: _duration,
      child: AnimatedOpacity(
        duration: _duration,
        curve: Curves.decelerate,
        opacity: groupTime ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.only(left: AppConfig.spacing),
          child: Text(
            time.formatted(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.5)),
          ),
        ),
      ),
    );
  }
}
