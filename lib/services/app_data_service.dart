import 'package:yt_playlists_plus/services/playlists_service.dart';
import 'package:yt_playlists_plus/services/settings_service/color_scheme_service.dart';
import 'package:yt_playlists_plus/services/settings_service/confirm_deletions_service.dart';
import 'package:yt_playlists_plus/services/settings_service/group_history_service.dart';
import 'package:yt_playlists_plus/services/settings_service/hide_topics_service.dart';
import 'package:yt_playlists_plus/services/settings_service/history_limit_service.dart';
import 'package:yt_playlists_plus/services/settings_service/planned_size_service.dart';
import 'package:yt_playlists_plus/services/settings_service/split_layout_service.dart';
import 'package:yt_playlists_plus/services/settings_service/theme_service.dart';

///Loads everything from Persistence with services so the UI updates
class AppDataService {
  ///Loads everything
  static Future<void> load() async {
    await ThemeService().load();
    await ColorSchemeService().load();
    await SplitLayoutService().load();
    await PlannedSizeService().load();
    await ConfirmDeletionsService().load();
    await HideTopicsService().load();
    await GroupHistoryService().load();
    await HistoryLimitService().load();
    await PlaylistsService().load();
  }

  ///Saves everything
  static Future<void> save() async {
    await ThemeService().save();
    await ColorSchemeService().save();
    await SplitLayoutService().save();
    await PlannedSizeService().save();
    await ConfirmDeletionsService().save();
    await HideTopicsService().save();
    await GroupHistoryService().save();
    await HistoryLimitService().save();
    await PlaylistsService().save();
  }
}
