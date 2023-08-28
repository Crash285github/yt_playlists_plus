import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';

///Toggles the application theme
class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool _isDarkModeOn = ApplicationTheme.get() == ApplicationTheme.dark;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _isDarkModeOn,
      title: Text(_isDarkModeOn ? "Dark mode" : "Light mode"),
      secondary: Icon(
          _isDarkModeOn ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
      onChanged: (value) {
        _isDarkModeOn
            ? ApplicationTheme.set(ApplicationTheme.light)
            : ApplicationTheme.set(ApplicationTheme.dark);
        setState(() {
          _isDarkModeOn = value;
        });
        Persistence.saveTheme();
      },
    );
  }
}
