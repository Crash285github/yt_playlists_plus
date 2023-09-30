import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/confirm_deletions_controller.dart';

class ConfirmDeletionsSetting extends StatefulWidget {
  const ConfirmDeletionsSetting({super.key});

  @override
  State<ConfirmDeletionsSetting> createState() =>
      _ConfirmDeletionsSettingState();
}

class _ConfirmDeletionsSettingState extends State<ConfirmDeletionsSetting> {
  bool _showConfirmDialog = ConfirmDeletionsController().confirmDeletions;

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

        ConfirmDeletionsController()
          ..set(value)
          ..save();
      },
    );
  }
}
