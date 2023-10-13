import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/group_history_controller.dart';

class GroupHistorySetting extends StatefulWidget {
  const GroupHistorySetting({super.key});

  @override
  State<GroupHistorySetting> createState() => _GroupHistorySettingState();
}

class _GroupHistorySettingState extends State<GroupHistorySetting> {
  bool _isHistoryTimeGrouped = GroupHistoryController().groupHistory;

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

        GroupHistoryController()
          ..set(value)
          ..save();
      },
    );
  }
}
