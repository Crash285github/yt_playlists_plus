import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/extensions/format_date_time.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/group_history_service.dart';

class VideoHistoryGroupTime extends StatelessWidget {
  final DateTime time;
  const VideoHistoryGroupTime({
    super.key,
    required this.time,
  });

  final duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    bool groupTime = Provider.of<GroupHistoryService>(context).groupHistory;

    return AnimatedContainer(
      height: groupTime ? 25 : 0,
      duration: duration,
      child: AnimatedOpacity(
        duration: duration,
        curve: Curves.decelerate,
        opacity: groupTime ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
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
