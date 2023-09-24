import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/services/playlists_service.dart';
import 'package:yt_playlists_plus/services/reorder_service.dart';
import 'package:yt_playlists_plus/services/settings_service/color_scheme_service.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/services/settings_service/confirm_deletions_service.dart';
import 'package:yt_playlists_plus/services/settings_service/group_history_service.dart';
import 'package:yt_playlists_plus/services/settings_service/hide_topics_service.dart';
import 'package:yt_playlists_plus/services/settings_service/planned_size_service.dart';
import 'package:yt_playlists_plus/services/settings_service/split_layout_service.dart';
import 'package:yt_playlists_plus/services/settings_service/theme_service.dart';
import 'package:yt_playlists_plus/application_wrapper.dart';

void main() async {
  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    await windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setSize(const Size(1100, 900));
      await windowManager.setMinimumSize(const Size(600, 400));
      await windowManager.setAlignment(Alignment.center);
      await windowManager.show();
    });
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Persistence()),
      ChangeNotifierProvider(create: (context) => ThemeService()),
      ChangeNotifierProvider(create: (context) => ColorSchemeService()),
      ChangeNotifierProvider(create: (context) => SplitLayoutService()),
      ChangeNotifierProvider(create: (context) => GroupHistoryService()),
      ChangeNotifierProvider(create: (context) => HideTopicsService()),
      ChangeNotifierProvider(create: (context) => ReorderService()),
      ChangeNotifierProvider(create: (context) => PlaylistsService()),
    ],
    child: const ThemeBuilder(),
  ));

  Persistence().load();

  SplitLayoutService().load();
  ColorSchemeService().load();
  ThemeService().load();
  if (Platform.isAndroid) PlannedSizeService().load();
  ConfirmDeletionsService().load();
  HideTopicsService().load();
  GroupHistoryService().load();
  PlaylistsService().load();
}
