import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/export_import_controller.dart';
import 'package:yt_playlists_plus/services/app_data_service.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';
import 'package:yt_playlists_plus/controller/reorder_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/color_scheme_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/confirm_deletions_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/group_history_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/hide_topics_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/history_limit_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/split_layout_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/theme_service.dart';
import 'package:yt_playlists_plus/view/theme_builder.dart';

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
      ChangeNotifierProvider(create: (context) => ThemeService()),
      ChangeNotifierProvider(create: (context) => ColorSchemeService()),
      ChangeNotifierProvider(create: (context) => SplitLayoutService()),
      ChangeNotifierProvider(create: (context) => GroupHistoryService()),
      ChangeNotifierProvider(create: (context) => HideTopicsService()),
      ChangeNotifierProvider(create: (context) => ReorderService()),
      ChangeNotifierProvider(create: (context) => PlaylistsService()),
      ChangeNotifierProvider(create: (context) => HistoryLimitService()),
      ChangeNotifierProvider(create: (context) => ConfirmDeletionsService()),
      ChangeNotifierProvider(create: (context) => ExportImportController()),
    ],
    child: const ThemeBuilder(),
  ));

  AppDataService.load();
}
