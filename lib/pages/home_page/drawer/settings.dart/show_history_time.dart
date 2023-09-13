import 'package:flutter/material.dart';

class ShowHistoryTimeSwitch extends StatefulWidget {
  const ShowHistoryTimeSwitch({super.key});

  @override
  State<ShowHistoryTimeSwitch> createState() => _ShowHistoryTimeSwitchState();
}

class _ShowHistoryTimeSwitchState extends State<ShowHistoryTimeSwitch> {
  bool _isHistoryTimeShown = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _isHistoryTimeShown,
      title: const Text("Show history time"),
      secondary: const Icon(Icons.history_toggle_off_outlined),
      subtitle: Text(
        "Above each group.",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
      ),
      onChanged: (value) {
        setState(() {
          _isHistoryTimeShown = value;
        });
      },
    );
  }
}
