import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/split_layout_enum.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/split_layout_controller.dart';
import 'package:yt_playlists_plus/view/templates/styled_dropdown.dart';

class SplitViewSetting extends StatefulWidget {
  const SplitViewSetting({super.key});

  @override
  State<SplitViewSetting> createState() => _SplitViewSettingState();
}

class _SplitViewSettingState extends State<SplitViewSetting> {
  SplitLayout _value = SplitLayoutController().portions;

  static const double pi = 3.1415926535897932;

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

          SplitLayoutController()
            ..set(value!)
            ..save();
        },
      ),
    );
  }
}
