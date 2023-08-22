import 'package:flutter/material.dart';

class ConfirmDeleteSwitch extends StatefulWidget {
  const ConfirmDeleteSwitch({super.key});

  @override
  State<ConfirmDeleteSwitch> createState() => _ConfirmDeleteSwitchState();
}

class _ConfirmDeleteSwitchState extends State<ConfirmDeleteSwitch> {
  bool _showConfirmDialog = true;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _showConfirmDialog,
      title: const Text("Confirm deletions"),
      subtitle: Text(
        "Show pop-up before playlist deletions",
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.grey),
      ),
      secondary: const Icon(Icons.question_mark),
      onChanged: (value) {
        setState(() {
          _showConfirmDialog = value;
        });
      },
    );
  }
}
