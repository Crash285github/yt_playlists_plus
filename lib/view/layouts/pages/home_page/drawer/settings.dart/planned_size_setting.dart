import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/planned_size_enum.dart';
import 'package:yt_playlists_plus/services/settings_service/planned_size_service.dart';
import 'package:yt_playlists_plus/view/templates/styled_dropdown.dart';

class PlannedSizeSetting extends StatefulWidget {
  const PlannedSizeSetting({super.key});

  @override
  State<PlannedSizeSetting> createState() => _PlannedSizeSettingState();
}

class _PlannedSizeSettingState extends State<PlannedSizeSetting> {
  PlannedSize _plannedSize = PlannedSizeService().plannedSize;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.draw_outlined),
      title: const Text("Planned height"),
      trailing: StyledDropdown<PlannedSize>(
        value: _plannedSize,
        items: [
          ...PlannedSize.values.map((PlannedSize size) {
            return DropdownMenuItem(
              value: size,
              child: Text(size.displayName),
            );
          })
        ],
        onChanged: (value) {
          setState(() {
            _plannedSize = value!;
          });

          PlannedSizeService()
            ..set(value)
            ..save();
        },
      ),
    );
  }
}
