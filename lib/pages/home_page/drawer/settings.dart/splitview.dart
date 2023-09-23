import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/constants.dart';
import 'package:yt_playlists_plus/services/split_layout_service.dart';
import 'package:yt_playlists_plus/widgets/styled_dropdown.dart';

class SplitViewSetting extends StatefulWidget {
  const SplitViewSetting({super.key});

  @override
  State<SplitViewSetting> createState() => _SplitViewSettingState();
}

class _SplitViewSettingState extends State<SplitViewSetting> {
  SplitLayout _value = SplitLayoutService().portions;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Transform.rotate(
          angle: (pi / 2), child: const Icon(Icons.splitscreen_outlined)),
      title: const Text("Split view"),
      trailing: StyledDropdown<SplitLayout>(
        value: _value,
        items: [
          ...SplitLayout.values.map((SplitLayout portions) {
            return DropdownMenuItem(
                value: portions, child: Text(portions.displayName));
          })
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
          });

          SplitLayoutService()
            ..set(value!)
            ..save();
        },
      ),
    );
  }
}
