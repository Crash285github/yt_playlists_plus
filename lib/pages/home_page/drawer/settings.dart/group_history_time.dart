import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class GroupHistoryTimeSwitch extends StatefulWidget {
  const GroupHistoryTimeSwitch({super.key});

  @override
  State<GroupHistoryTimeSwitch> createState() => _GroupHistoryTimeSwitchState();
}

class _GroupHistoryTimeSwitchState extends State<GroupHistoryTimeSwitch> {
  bool _isHistoryTimeGrouped = Persistence.groupHistoryTime;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _isHistoryTimeGrouped,
      title: const Text("Group history time"),
      secondary: const Icon(Icons.history_toggle_off_outlined),
      subtitle: Text(
        "Show once above each group.",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
      ),
      onChanged: (value) {
        setState(() {
          _isHistoryTimeGrouped = value;
          Persistence.groupHistoryTime = value;
          Persistence.saveGroupHistoryTime();
        });
      },
    );
  }
}
