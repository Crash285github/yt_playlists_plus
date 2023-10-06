import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/config.dart';
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
      await windowManager.setSize(AppConfig.desktopSizeDef);
      await windowManager.setMinimumSize(AppConfig.desktopSizeMin);
      await windowManager.setAlignment(AppConfig.desktopAlignment);
      await windowManager.show();
    });
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeController()),
      ChangeNotifierProvider(create: (_) => ColorSchemeController()),
      ChangeNotifierProvider(create: (_) => SplitLayoutController()),
      ChangeNotifierProvider(create: (_) => GroupHistoryController()),
      ChangeNotifierProvider(create: (_) => HideTopicsController()),
      ChangeNotifierProvider(create: (_) => ReorderController()),
      ChangeNotifierProvider(create: (_) => PlaylistsController()),
      ChangeNotifierProvider(create: (_) => HistoryLimitController()),
      ChangeNotifierProvider(create: (_) => ConfirmDeletionsController()),
      ChangeNotifierProvider(create: (_) => ExportImportController()),
    ],
    child: const ThemeBuilder(),
  ));

  AppDataService.load();
}
