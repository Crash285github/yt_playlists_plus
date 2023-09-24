import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
import 'package:yt_playlists_plus/model/playlist/playlist.dart';

///The Application's Persistent Storage
///
///It implements the Singleton Design Pattern
class Persistence with ChangeNotifier {
  //? Singleton Design Pattern
  static final Persistence _instance = Persistence._internal();
  Persistence._internal();
  factory Persistence() => _instance;

  //#endregion

  static bool _canExImport = true;
  static bool get canExImport => _canExImport;

  void mayEnableExportImport() {
    if (PlaylistsService().playlists.any((element) =>
        element.status == PlaylistStatus.fetching ||
        element.status == PlaylistStatus.checking)) {
      return;
    }
    _canExImport = true;
    _instance.notifyListeners();
  }

  static void disableExportImport() {
    _canExImport = false;
    _instance.notifyListeners();
  }

  Future<void> save() async {
    await ThemeService().save();
    await PlaylistsService().save();
    await HideTopicsService().save();
    await ColorSchemeService().save();
    await SplitLayoutService().save();
    await PlannedSizeService().save();
    await HistoryLimitService().save();
    await GroupHistoryService().save();
    await ConfirmDeletionsService().save();
  }

  Future<bool> import() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      initialDirectory: dir.path,
      allowedExtensions: ['json'],
      type: FileType.custom,
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      Map json = jsonDecode(await file.readAsString());
      ThemeService().set(json[ThemeService().mapKey] ?? AppTheme.light);
      ColorSchemeService().set(AppColorScheme.values
          .byName(json[ColorSchemeService().mapKey] ?? AppColorScheme.dynamic));
      SplitLayoutService().set(SplitLayout.values
          .byName(json[SplitLayoutService().mapKey] ?? SplitLayout.uneven));
      PlannedSizeService().set(PlannedSize.values
          .byName(json[PlannedSizeService().mapKey] ?? PlannedSize.normal));
      ConfirmDeletionsService()
          .set(json[ConfirmDeletionsService().mapKey] ?? true);
      HideTopicsService().set(json[HideTopicsService().mapKey] ?? false);
      HistoryLimitService().set(json[HistoryLimitService().mapKey]);
      GroupHistoryService().set(json[GroupHistoryService().mapKey] ?? false);

      PlaylistsService().playlists.clear();
      notifyListeners();

      //hack: refresh wont work otherwise after import
      await Future.delayed(const Duration(milliseconds: 250));

      PlaylistsService()
          .playlists
          .addAll((json[PlaylistsService().mapKey] as List).map((element) {
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
      ThemeService().mapKey: ThemeService().theme,
      ColorSchemeService().mapKey: ColorSchemeService().scheme,
      SplitLayoutService().mapKey: SplitLayoutService().portions,
      PlannedSizeService().mapKey: PlannedSizeService().plannedSize,
      ConfirmDeletionsService().mapKey:
          ConfirmDeletionsService().confirmDeletions,
      HideTopicsService().mapKey: HideTopicsService().hideTopics,
      HistoryLimitService().mapKey: HistoryLimitService().limit,
      GroupHistoryService().mapKey: GroupHistoryService().groupHistoryTime,
      PlaylistsService().mapKey: PlaylistsService().playlists,
    };

    await file.writeAsString(jsonEncode(json));
    return true;
  }
}
