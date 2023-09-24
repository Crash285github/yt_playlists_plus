import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/settings_service/planned_size_service.dart';
import 'package:yt_playlists_plus/view/widgets/styled_dropdown.dart';

class InitialPlannedSizeSetting extends StatefulWidget {
  const InitialPlannedSizeSetting({super.key});

  @override
  State<InitialPlannedSizeSetting> createState() =>
      _InitialPlannedSizeSettingState();
}

class _InitialPlannedSizeSettingState extends State<InitialPlannedSizeSetting> {
  PlannedSize _plannedSize = PlannedSizeService().plannedSize;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.draw_outlined),
      title: const Text("Planned height"),
      trailing: StyledDropdown<PlannedSize>(
        value: _plannedSize,
        items: [
          DropdownMenuItem(
            value: PlannedSize.normal,
            child: Text(PlannedSize.normal.displayName),
          ),
          DropdownMenuItem(
            value: PlannedSize.minimal,
            child: Text(PlannedSize.minimal.displayName),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _plannedSize = value!;
            PlannedSizeService().set(value);
            PlannedSizeService().save();
          });
        },
      ),
    );
  }
}
