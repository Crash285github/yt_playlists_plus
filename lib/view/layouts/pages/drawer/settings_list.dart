import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/view/layouts/pages/drawer/settings.dart/color_scheme_setting.dart';
import 'package:yt_playlists_plus/view/layouts/pages/drawer/settings.dart/confirm_deletions_setting.dart';
import 'package:yt_playlists_plus/view/layouts/pages/drawer/settings.dart/hide_topics_setting.dart';
import 'package:yt_playlists_plus/view/layouts/pages/drawer/settings.dart/history_limit_setting.dart';
import 'package:yt_playlists_plus/view/layouts/pages/drawer/settings.dart/planned_size_setting.dart';
import 'package:yt_playlists_plus/view/layouts/pages/drawer/settings.dart/reorder.dart';
import 'package:yt_playlists_plus/view/layouts/pages/drawer/settings.dart/group_history_setting.dart';
import 'package:yt_playlists_plus/view/layouts/pages/drawer/settings.dart/splitview.dart';
import 'package:yt_playlists_plus/view/layouts/pages/drawer/settings.dart/theme.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final bool canSnap = MediaQuery.of(context).size.height * 0.2 > 100;

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            "Some changes may apply after a restart.",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.5)),
          ),
          const ThemeSwitch(),
          const ConfirmDeletionsSetting(),
          const HideTopicsSetting(),
          if (Platform.isAndroid && canSnap) const PlannedSizeSetting(),
          const ColorSchemeSetting(),
          const SplitViewSetting(),
          const HistoryLimitSetting(),
          const GroupHistorySetting(),
          if (PlaylistsController().playlists.length > 1)
            const ReorderSetting(),
        ],
      ),
    );
  }
}
