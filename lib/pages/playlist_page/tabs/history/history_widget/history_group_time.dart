import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/services/extensions.dart';
import 'package:yt_playlists_plus/services/settings_service/group_history_service.dart';

class HistoryGroupTime extends StatelessWidget {
  final DateTime time;
  const HistoryGroupTime({
    super.key,
    required this.time,
  });

  final duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    bool groupTime = Provider.of<GroupHistoryService>(context).groupHistoryTime;

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
