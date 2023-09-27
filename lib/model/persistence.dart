import 'dart:io';
import 'package:yt_playlists_plus/services/playlists_service.dart';
import 'package:yt_playlists_plus/services/settings_service/color_scheme_service.dart';
import 'package:yt_playlists_plus/services/settings_service/confirm_deletions_service.dart';
import 'package:yt_playlists_plus/services/settings_service/group_history_service.dart';
import 'package:yt_playlists_plus/services/settings_service/hide_topics_service.dart';
import 'package:yt_playlists_plus/services/settings_service/history_limit_service.dart';
import 'package:yt_playlists_plus/services/settings_service/planned_size_service.dart';
import 'package:yt_playlists_plus/services/settings_service/split_layout_service.dart';
import 'package:yt_playlists_plus/services/settings_service/theme_service.dart';

///The Application's Persistent Storage
class Persistence {
  static Future<void> load() async {
    await ThemeService().load();
    await PlaylistsService().load();
    await HideTopicsService().load();
    await ColorSchemeService().load();
    await SplitLayoutService().load();
    await HistoryLimitService().load();
    await GroupHistoryService().load();
    await ConfirmDeletionsService().load();
    if (Platform.isAndroid) await PlannedSizeService().load();
  }

  static Future<void> save() async {
    await ThemeService().save();
    await PlaylistsService().save();
    await HideTopicsService().save();
    await ColorSchemeService().save();
    await SplitLayoutService().save();
    await HistoryLimitService().save();
    await GroupHistoryService().save();
    await ConfirmDeletionsService().save();
    if (Platform.isAndroid) await PlannedSizeService().save();
  }
}
