import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/settings_service/color_scheme_service.dart';
import 'package:yt_playlists_plus/view/templates/styled_dropdown.dart';

class ColorSchemeSetting extends StatefulWidget {
  const ColorSchemeSetting({super.key});

  @override
  State<ColorSchemeSetting> createState() => _ColorSchemeSettingState();
}

class _ColorSchemeSettingState extends State<ColorSchemeSetting> {
  AppColorScheme _color = ColorSchemeService().scheme;

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

          ColorSchemeService()
            ..set(value ?? AppColorScheme.dynamic)
            ..save();
        },
      ),
    );
  }
}
