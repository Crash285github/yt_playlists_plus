import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/app_color_scheme_enum.dart';
import 'package:yt_playlists_plus/enums/app_theme_enum.dart';
import 'package:yt_playlists_plus/enums/planned_size_enum.dart';
import 'package:yt_playlists_plus/enums/split_layout_enum.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/enums/playlist_status.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/color_scheme_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/confirm_deletions_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/group_history_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/hide_topics_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/history_limit_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/planned_size_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/split_layout_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/theme_service.dart';
import 'package:yt_playlists_plus/view/layouts/responsive/split_view.dart';

///Manages importing & exporting
class ExportImportController extends ChangeNotifier {
  bool _enabled = true;
  bool get enabled => _enabled;

  void tryEnable() {
    if (PlaylistsService().playlists.any((playlist) =>
        playlist.status == PlaylistStatus.fetching ||
        playlist.status == PlaylistStatus.checking ||
        playlist.status == PlaylistStatus.downloading)) {
      return;
    }
    _enabled = true;
    notifyListeners();
  }

  void disable() {
    _enabled = false;
    notifyListeners();
  }

  Future<bool> import() async {
    Map? json = await Persistence.import();
    if (json == null) return false;

    final AppTheme appTheme =
        AppTheme.values[json[Persistence.appTheme.key] ?? AppTheme.light];
    ThemeService().set(appTheme);

    final AppColorScheme appColorScheme = AppColorScheme
        .values[json[Persistence.colorScheme.key] ?? AppColorScheme.dynamic];
    ColorSchemeService().set(appColorScheme);

    final SplitLayout splitLayout = SplitLayout
        .values[json[Persistence.splitLayout.key] ?? SplitLayout.uneven];
    SplitLayoutService().set(splitLayout);

    if (Platform.isAndroid) {
      final PlannedSize plannedSize = PlannedSize
          .values[json[Persistence.plannedSize.key] ?? PlannedSize.normal];
      PlannedSizeService().set(plannedSize);
    }

    final bool confirmDeletions =
        json[Persistence.confirmDeletions.key] ?? true;
    ConfirmDeletionsService().set(confirmDeletions);

    final bool hideTopics = json[Persistence.hideTopics.key] ?? false;
    HideTopicsService().set(hideTopics);

    final bool groupHistory = json[Persistence.groupHistory.key] ?? false;
    GroupHistoryService().set(groupHistory);

    final int? historyLimit = json[Persistence.historyLimit.key];
    HistoryLimitService().set(historyLimit);

    SplitViewState.playlist = null;
    List<PlaylistController> list = (json[Persistence.playlists.key] as List)
        .map((final playlistJson) => PlaylistController.fromJson(playlistJson))
        .toList();
    PlaylistsService().replace(list);

    return true;
  }

  Future<bool> export() async => Persistence.export();

  //__ Singleton
  static final ExportImportController _instance = ExportImportController._();
  factory ExportImportController() => _instance;
  ExportImportController._();
}
