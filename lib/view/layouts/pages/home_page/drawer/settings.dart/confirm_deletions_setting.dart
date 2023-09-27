import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/settings_service/confirm_deletions_service.dart';

class ConfirmDeletionsSetting extends StatefulWidget {
  const ConfirmDeletionsSetting({super.key});

  @override
  State<ConfirmDeletionsSetting> createState() =>
      _ConfirmDeletionsSettingState();
}

class _ConfirmDeletionsSettingState extends State<ConfirmDeletionsSetting> {
  bool _showConfirmDialog = ConfirmDeletionsService().confirmDeletions;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _showConfirmDialog,
      title: const Text("Confirm deletions"),
      subtitle: Text(
        "Show pop-up before playlist deletions.",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
      ),
      secondary: const Icon(Icons.delete_outline),
      onChanged: (value) {
        setState(() {
          _showConfirmDialog = value;
        });

        ConfirmDeletionsService()
          ..set(value)
          ..save();
      },
    );
  }
}
