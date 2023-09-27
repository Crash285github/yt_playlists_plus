import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/settings_service/group_history_service.dart';

class GroupHistorySetting extends StatefulWidget {
  const GroupHistorySetting({super.key});

  @override
  State<GroupHistorySetting> createState() => _GroupHistorySettingState();
}

class _GroupHistorySettingState extends State<GroupHistorySetting> {
  bool _isHistoryTimeGrouped = GroupHistoryService().groupHistory;

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
        });

        GroupHistoryService()
          ..set(value)
          ..save();
      },
    );
  }
}
