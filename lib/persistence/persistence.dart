import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/services/settings_service/color_scheme_service.dart';
import 'package:yt_playlists_plus/services/settings_service/confirm_deletions_service.dart';
import 'package:yt_playlists_plus/services/settings_service/group_history_service.dart';
import 'package:yt_playlists_plus/services/settings_service/hide_topics_service.dart';
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

  //#region Playlist data

  ///The currently stored Playlists
  ///
  ///Requires Persistence.load() to get the data
  static List<Playlist> get playlists => _playlists;
  static List<Playlist> _playlists = []; //private representation

  ///Adds a `Playlist` item to the Persistent storage, and alerts listeners
  ///
  ///Doesn't save on it's own
  static void addPlaylist(Playlist item) {
    if (_playlists.contains(item)) {
      //? playlist videos can be different, == only checks ids
      _playlists.remove(item);
    }

    _playlists.add(item);
    _instance.notifyListeners();
  }

  ///Removes a `Playlist` item from the Persistent storage, and alerts listeners
  ///
  ///Doesn't save on its own
  static void removePlaylist(Playlist item) {
    item.cancelNetworking();
    _playlists.remove(item);
    _instance.notifyListeners();
  }

  //#endregion

  static bool _canExImport = true;
  static bool get canExImport => _canExImport;

  static void mayEnableExportImport() {
    if (_playlists.any((element) =>
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

  ///Size of each playlist's history
  ///
  ///`null` means infinite
  static int? _historyLimit;
  static int? get historyLimit => _historyLimit;
  static set historyLimit(int? value) {
    _historyLimit = value;
    _instance.notifyListeners();
  }

  ///Loads the Persistent Storage, and alerts listeners when finished
  static Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      historyLimit = prefs.getInt('historyLimit');
      if (historyLimit == -1) {
        historyLimit = null;
      }
    } catch (_) {}
    //? playlists
    List<String> val = prefs.getStringList('playlists') ?? [];
    if (val.isEmpty) return;
    _playlists = val.map((e) => Playlist.fromJson(jsonDecode(e))).toList();
    _instance.notifyListeners();
  }

  static bool _isSavingHistoryLimit = false;
  static Future<bool> saveHistoryLimit() async {
    if (_isSavingHistoryLimit) return false;
    _isSavingHistoryLimit = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .setInt('historyLimit', historyLimit ?? -1)
        .then((_) => _isSavingHistoryLimit = false);
  }

  static bool _isSavingPlaylists = false;
  static Future<bool> savePlaylists() async {
    if (_isSavingPlaylists) return false;
    _isSavingPlaylists = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .setStringList(
            'playlists', (_playlists.map((e) => jsonEncode(e))).toList())
        .then((_) => _isSavingPlaylists = false);
  }

  static Future<void> saveAll() async {
    await saveHistoryLimit();
    await savePlaylists();
  }

  static Future<bool> import() async {
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
      HideTopicsService().set(json['hideTopics'] ?? false);
      historyLimit = json['historyLimit'];
      GroupHistoryService().set(json['groupHistoryTime'] ?? false);

      playlists.clear();
      _instance.notifyListeners();

      //hack: refresh wont work otherwise after import
      await Future.delayed(const Duration(milliseconds: 250));

      playlists.addAll((json['playlists'] as List).map((element) {
        return Playlist.fromJson(element);
      }));
      _instance.notifyListeners();
      return true;
    }

    return false;
  }

  static Future<bool> export() async {
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
      'historyLimit': historyLimit,
      GroupHistoryService().mapKey: GroupHistoryService().groupHistoryTime,
      'playlists': playlists,
    };

    await file.writeAsString(jsonEncode(json));
    return true;
  }
}
