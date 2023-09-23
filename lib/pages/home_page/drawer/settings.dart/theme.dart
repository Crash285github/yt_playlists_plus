import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/settings_service/theme_service.dart';

///Toggles the application theme
class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool _isDarkMode = AppThemeService().theme != AppTheme.light;
  bool _isAmoled = AppThemeService().theme == AppTheme.amoled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _isDarkMode = true;
          _isAmoled = !_isAmoled;

          AppThemeService()
            ..set(_isAmoled ? AppTheme.amoled : AppTheme.dark)
            ..save();
        });
      },
      child: SwitchListTile(
        value: _isDarkMode,
        title: Text(
          AppThemeService().theme == AppTheme.amoled
              ? "AMOLED mode"
              : "Dark mode",
        ),
        secondary: const Icon(Icons.dark_mode_outlined),
        onChanged: (value) {
          setState(() {
            _isDarkMode = value;
            _isAmoled = false;
          });

          AppThemeService()
            ..set(_isDarkMode ? AppTheme.dark : AppTheme.light)
            ..save();
        },
      ),
    );
  }
}
