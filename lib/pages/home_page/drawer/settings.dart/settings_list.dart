import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/settings.dart/color.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/settings.dart/confirm_delete.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/settings.dart/hide_topics.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/settings.dart/history_size.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/settings.dart/initial_planned_size.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/settings.dart/reorder.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/settings.dart/splitview.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/settings.dart/theme.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ThemeSwitch(),
          const ConfirmDeleteSwitch(),
          const HideTopicsSwitch(),
          Platform.isAndroid
              ? const InitialPlannedSizeSetting()
              : const SizedBox.shrink(),
          const ColorSetting(),
          const SplitViewSetting(),
          const HistorySizeSetting(),
          const ReorderPlaylistsSetting(),
        ],
      ),
    );
  }
}
