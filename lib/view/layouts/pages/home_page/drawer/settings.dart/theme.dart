import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/app_theme_enum.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/theme_controller.dart';

///Toggles the application theme
class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool _isDarkMode = ThemeController().theme != AppTheme.light;
  bool _isAmoled = ThemeController().theme == AppTheme.amoled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _isDarkMode = true;
          _isAmoled = !_isAmoled;

          ThemeController()
            ..set(_isAmoled ? AppTheme.amoled : AppTheme.dark)
            ..save();
        });
      },
      child: SwitchListTile(
        value: _isDarkMode,
        title: Text(
          ThemeController().theme == AppTheme.amoled
              ? "AMOLED mode"
              : "Dark mode",
        ),
        secondary: const Icon(Icons.dark_mode_outlined),
        onChanged: (value) {
          setState(() {
            _isDarkMode = value;
            _isAmoled = false;
          });

          ThemeController()
            ..set(_isDarkMode ? AppTheme.dark : AppTheme.light)
            ..save();
        },
      ),
    );
  }
}
