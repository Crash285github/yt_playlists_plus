import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/color_scheme.dart';
import 'package:yt_playlists_plus/widgets/styled_dropdown.dart';

class ColorSetting extends StatefulWidget {
  const ColorSetting({super.key});

  @override
  State<ColorSetting> createState() => _ColorSettingState();
}

class _ColorSettingState extends State<ColorSetting> {
  AppColorScheme _color = AppColorSchemeService().colorScheme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.color_lens_outlined),
      title: const Text("App color"),
      trailing: StyledDropdown<AppColorScheme>(
        value: _color,
        items: [
          ...AppColorScheme.values.map((AppColorScheme color) {
            return DropdownMenuItem<AppColorScheme>(
              value: color,
              child: Text(
                color.displayName,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: color.color),
              ),
            );
          })
        ],
        onChanged: (value) {
          setState(() {
            _color = value!;
          });

          AppColorSchemeService()
            ..set(value ?? AppColorScheme.dynamic)
            ..save();
        },
      ),
    );
  }
}
