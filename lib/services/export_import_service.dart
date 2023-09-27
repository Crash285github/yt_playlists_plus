import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/app_color_scheme_enum.dart';
import 'package:yt_playlists_plus/enums/app_theme_enum.dart';
import 'package:yt_playlists_plus/enums/planned_size_enum.dart';
import 'package:yt_playlists_plus/enums/split_layout_enum.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/services/playlists_service.dart';
import 'package:yt_playlists_plus/services/settings_service/color_scheme_service.dart';
import 'package:yt_playlists_plus/services/settings_service/confirm_deletions_service.dart';
import 'package:yt_playlists_plus/services/settings_service/group_history_service.dart';
import 'package:yt_playlists_plus/services/settings_service/hide_topics_service.dart';
import 'package:yt_playlists_plus/services/settings_service/history_limit_service.dart';
import 'package:yt_playlists_plus/services/settings_service/planned_size_service.dart';
import 'package:yt_playlists_plus/services/settings_service/split_layout_service.dart';
import 'package:yt_playlists_plus/services/settings_service/theme_service.dart';
import 'package:yt_playlists_plus/view/layouts/responsive/split_view.dart';

///Manages importing & exporting
class ExportImportService extends ChangeNotifier {
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
        AppTheme.values[json[ThemeService().storageKey] ?? AppTheme.light];
    ThemeService().set(appTheme);

    final AppColorScheme appColorScheme = AppColorScheme.values[
        json[ColorSchemeService().storageKey] ?? AppColorScheme.dynamic];
    ColorSchemeService().set(appColorScheme);

    final SplitLayout splitLayout = SplitLayout
        .values[json[SplitLayoutService().storageKey] ?? SplitLayout.uneven];
    SplitLayoutService().set(splitLayout);

    if (Platform.isAndroid) {
      final PlannedSize plannedSize = PlannedSize
          .values[json[PlannedSizeService().storageKey] ?? PlannedSize.normal];
      PlannedSizeService().set(plannedSize);
    }

    final bool confirmDeletions =
        json[ConfirmDeletionsService().storageKey] ?? true;
    ConfirmDeletionsService().set(confirmDeletions);

    final bool hideTopics = json[HideTopicsService().storageKey] ?? false;
    HideTopicsService().set(hideTopics);

    final bool groupHistory = json[GroupHistoryService().storageKey] ?? false;
    GroupHistoryService().set(groupHistory);

    final int? historyLimit = json[HistoryLimitService().storageKey];
    HistoryLimitService().set(historyLimit);

    SplitViewState.playlist = null;
    List<Playlist> list = (json[PlaylistsService().storageKey] as List)
        .map((final playlistJson) => Playlist.fromJson(playlistJson))
        .toList();
    PlaylistsService().replace(list);

    return true;
  }

  Future<bool> export() async => Persistence.export();

  //__ Singleton
  static final ExportImportService _instance = ExportImportService._();
  factory ExportImportService() => _instance;
  ExportImportService._();
}
