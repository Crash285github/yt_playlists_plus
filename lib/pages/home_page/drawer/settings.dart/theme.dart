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
  bool _isDarkMode = ApplicationTheme.get() != ApplicationTheme.light;
  bool _isAmoled = ApplicationTheme.get() == ApplicationTheme.amoled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          if (_isAmoled) {
            ApplicationTheme.set(ApplicationTheme.dark);
            _isDarkMode = true;
            _isAmoled = false;
          } else {
            ApplicationTheme.set(ApplicationTheme.amoled);
            _isDarkMode = true;
            _isAmoled = true;
          }
          Persistence.saveTheme();
        });
      },
      child: SwitchListTile(
        value: _isDarkMode,
        title: Text(
          ApplicationTheme.get() == ApplicationTheme.amoled
              ? "AMOLED mode"
              : "Dark mode",
        ),
        secondary: const Icon(Icons.dark_mode_outlined),
        onChanged: (value) {
          _isDarkMode
              ? ApplicationTheme.set(ApplicationTheme.light)
              : ApplicationTheme.set(ApplicationTheme.dark);
          setState(() {
            _isDarkMode = value;
            _isAmoled = false;
          });
          Persistence.saveTheme();
        },
      ),
    );
  }
}
