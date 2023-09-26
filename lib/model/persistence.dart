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
class Persistence with ChangeNotifier {
  //#endregion

  bool _canExImport = true;
  bool get canExImport => _canExImport;

  void tryEnableExportImport() {
    if (PlaylistsService().playlists.any((playlist) =>
        playlist.status == PlaylistStatus.fetching ||
        playlist.status == PlaylistStatus.checking ||
        playlist.status == PlaylistStatus.downloading)) {
      return;
    }
    _canExImport = true;
    notifyListeners();
  }

  void disableExportImport() {
    _canExImport = false;
    notifyListeners();
  }

  Future<void> load() async {
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

  Future<void> save() async {
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

  //__ Singleton Design Pattern
  static final Persistence _instance = Persistence._internal();
  Persistence._internal();
  factory Persistence() => _instance;
}
