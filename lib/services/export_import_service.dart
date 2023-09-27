import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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

  bool _importing = false;
  Future<bool> import() async {
    if (_importing) return false;
    _importing = true;

    final Directory dir = await getApplicationDocumentsDirectory();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      initialDirectory: dir.path,
      allowedExtensions: ['json'],
      type: FileType.custom,
    );

    _importing = false;
    if (result != null) {
      File file = File(result.files.single.path!);
      Map json = jsonDecode(await file.readAsString());
      ThemeService().set(json[ThemeService().storableKey] ?? AppTheme.light);
      ColorSchemeService().set(AppColorScheme.values.byName(
          json[ColorSchemeService().storableKey] ?? AppColorScheme.dynamic));
      SplitLayoutService().set(SplitLayout.values.byName(
          json[SplitLayoutService().storableKey] ?? SplitLayout.uneven));
      PlannedSizeService().set(PlannedSize.values.byName(
          json[PlannedSizeService().storableKey] ?? PlannedSize.normal));
      ConfirmDeletionsService()
          .set(json[ConfirmDeletionsService().storableKey] ?? true);
      HideTopicsService().set(json[HideTopicsService().storableKey] ?? false);
      HistoryLimitService().set(json[HistoryLimitService().storableKey]);
      GroupHistoryService()
          .set(json[GroupHistoryService().storableKey] ?? false);

      PlaylistsService().playlists.clear();
      notifyListeners();

      //hack: refresh wont work otherwise after import
      await Future.delayed(const Duration(milliseconds: 250));

      PlaylistsService()
          .playlists
          .addAll((json[PlaylistsService().storableKey] as List).map((element) {
            return Playlist.fromJson(element);
          }));
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> export() async {
    String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir == null) return false; //?? cancelled

    final File file =
        File('$dir/export${DateTime.now().millisecondsSinceEpoch}.json');

    final json = {
      ThemeService().storableKey: ThemeService().theme,
      ColorSchemeService().storableKey: ColorSchemeService().scheme,
      SplitLayoutService().storableKey: SplitLayoutService().portions,
      PlannedSizeService().storableKey: PlannedSizeService().plannedSize,
      ConfirmDeletionsService().storableKey:
          ConfirmDeletionsService().confirmDeletions,
      HideTopicsService().storableKey: HideTopicsService().hideTopics,
      HistoryLimitService().storableKey: HistoryLimitService().limit,
      GroupHistoryService().storableKey: GroupHistoryService().groupHistoryTime,
      PlaylistsService().storableKey: PlaylistsService().playlists,
    };

    await file.writeAsString(jsonEncode(json));
    return true;
  }

  //__ Singleton
  static final ExportImportService _instance = ExportImportService._();
  factory ExportImportService() => _instance;
  ExportImportService._();
}
