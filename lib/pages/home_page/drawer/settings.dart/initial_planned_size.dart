import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/persistence/initial_planned_size.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class InitialPlannedSizeSetting extends StatefulWidget {
  const InitialPlannedSizeSetting({super.key});

  @override
  State<InitialPlannedSizeSetting> createState() =>
      _InitialPlannedSizeSettingState();
}

class _InitialPlannedSizeSettingState extends State<InitialPlannedSizeSetting> {
  InitialPlannedSize _initialPlannedSize = Persistence.initialPlannedSize;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.draw_outlined),
      title: const Text("Planned height"),
      trailing: DropdownButton(
        value: _initialPlannedSize,
        iconSize: 0,
        items: [
          DropdownMenuItem(
            value: InitialPlannedSize.normal,
            child: Text(InitialPlannedSize.normal.displayName),
          ),
          DropdownMenuItem(
            value: InitialPlannedSize.minimal,
            child: Text(InitialPlannedSize.minimal.displayName),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _initialPlannedSize = value!;
            Persistence.initialPlannedSize = value;
            Persistence.saveInitialPlannedSize();
          });
        },
      ),
    );
  }
}
