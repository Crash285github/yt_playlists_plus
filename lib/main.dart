import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/export_import_controller.dart';
import 'package:yt_playlists_plus/services/app_data_service.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';
import 'package:yt_playlists_plus/controller/reorder_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/color_scheme_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/confirm_deletions_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/group_history_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/hide_topics_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/history_limit_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/split_layout_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/theme_controller.dart';
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
      ChangeNotifierProvider(create: (context) => ThemeController()),
      ChangeNotifierProvider(create: (context) => ColorSchemeController()),
      ChangeNotifierProvider(create: (context) => SplitLayoutController()),
      ChangeNotifierProvider(create: (context) => GroupHistoryController()),
      ChangeNotifierProvider(create: (context) => HideTopicsController()),
      ChangeNotifierProvider(create: (context) => ReorderController()),
      ChangeNotifierProvider(create: (context) => PlaylistsController()),
      ChangeNotifierProvider(create: (context) => HistoryLimitController()),
      ChangeNotifierProvider(create: (context) => ConfirmDeletionsController()),
      ChangeNotifierProvider(create: (context) => ExportImportController()),
    ],
    child: const ThemeBuilder(),
  ));

  AppDataService.load();
}
