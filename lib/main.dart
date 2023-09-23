import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/services/color_scheme_service.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/services/split_layout_service.dart';
import 'package:yt_playlists_plus/services/theme_service.dart';
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
      ChangeNotifierProvider(create: (context) => AppThemeService()),
      ChangeNotifierProvider(create: (context) => AppColorSchemeService()),
      ChangeNotifierProvider(create: (context) => SplitLayoutService()),
    ],
    child: const ApplicationWrapper(),
  ));

  Persistence.load();
  
  SplitLayoutService().load();
  AppColorSchemeService().load();
  AppThemeService().load();
}
