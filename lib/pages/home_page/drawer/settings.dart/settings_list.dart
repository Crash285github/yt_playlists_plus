import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/settings.dart/theme.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ThemeSwitch(),
      ],
    );
  }
}
