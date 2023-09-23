import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/settings_service/confirm_deletions_service.dart';

class ConfirmDeleteSwitch extends StatefulWidget {
  const ConfirmDeleteSwitch({super.key});

  @override
  State<ConfirmDeleteSwitch> createState() => _ConfirmDeleteSwitchState();
}

class _ConfirmDeleteSwitchState extends State<ConfirmDeleteSwitch> {
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
