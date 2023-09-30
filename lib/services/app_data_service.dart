import 'package:yt_playlists_plus/controller/playlists_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/color_scheme_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/confirm_deletions_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/group_history_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/hide_topics_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/history_limit_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/planned_size_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/split_layout_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/theme_controller.dart';

///Loads everything from Persistence with services so the UI updates
class AppDataService {
  ///Loads everything
  static Future<void> load() async {
    await ThemeController().load();
    await ColorSchemeController().load();
    await SplitLayoutController().load();
    await PlannedSizeController().load();
    await ConfirmDeletionsController().load();
    await HideTopicsController().load();
    await GroupHistoryController().load();
    await HistoryLimitController().load();
    await PlaylistsController().load();
  }

  ///Saves everything
  static Future<void> save() async {
    await ThemeController().save();
    await ColorSchemeController().save();
    await SplitLayoutController().save();
    await PlannedSizeController().save();
    await ConfirmDeletionsController().save();
    await HideTopicsController().save();
    await GroupHistoryController().save();
    await HistoryLimitController().save();
    await PlaylistsController().save();
  }
}
