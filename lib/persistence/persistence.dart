import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/services/settings_service/color_scheme_service.dart';
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

  static bool _canReorder = false;
  static bool get canReorder => _canReorder;

  static void enableReorder() {
    _canReorder = true;
    _instance.notifyListeners();
  }

  static void disableReorder() {
    _canReorder = false;
    _instance.notifyListeners();
  }

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

  ///Whether to show a confirmation dialog before deleting playlists
  static bool confirmDeletions = true;

  ///Hide ' - Topic' from channel names
  static bool _hideTopics = false;
  static bool get hideTopics => _hideTopics;
  static set hideTopics(bool value) {
    _hideTopics = value;
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

  ///Show the exact time above each history group
  static bool _groupHistoryTime = false;
  static bool get groupHistoryTime => _groupHistoryTime;
  static set groupHistoryTime(bool value) {
    _groupHistoryTime = value;
    _instance.notifyListeners();
  }

  ///Loads the Persistent Storage, and alerts listeners when finished
  static Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      confirmDeletions = prefs.getBool('confirmDeletions') ?? true;
    } catch (_) {}
    try {
      hideTopics = prefs.getBool('hideTopics') ?? false;
    } catch (_) {}
    try {
      historyLimit = prefs.getInt('historyLimit');
      if (historyLimit == -1) {
        historyLimit = null;
      }
    } catch (_) {}
    try {
      groupHistoryTime = prefs.getBool('groupHistoryTime') ?? false;
    } catch (_) {}

    //? playlists
    List<String> val = prefs.getStringList('playlists') ?? [];
    if (val.isEmpty) return;
    _playlists = val.map((e) => Playlist.fromJson(jsonDecode(e))).toList();
    _instance.notifyListeners();
  }

  static bool _isSavingConfirmDeletions = false;
  static Future<bool> saveConfirmDeletions() async {
    if (_isSavingConfirmDeletions) return false;
    _isSavingConfirmDeletions = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .setBool('confirmDeletions', confirmDeletions)
        .then((_) => _isSavingConfirmDeletions = false);
  }

  static bool _isSavingHideTopics = false;
  static Future<bool> saveHideTopics() async {
    if (_isSavingHideTopics) return false;
    _isSavingHideTopics = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .setBool('hideTopics', hideTopics)
        .then((_) => _isSavingHideTopics = false);
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

  static bool _isSavingGroupHistoryTime = false;
  static Future<bool> saveGroupHistoryTime() async {
    if (_isSavingGroupHistoryTime) return false;
    _isSavingGroupHistoryTime = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .setBool('groupHistoryTime', groupHistoryTime)
        .then((_) => _isSavingGroupHistoryTime = false);
  }

  static Future<void> saveAll() async {
    await saveHistoryLimit();
    await saveGroupHistoryTime();
    await saveConfirmDeletions();
    await saveHideTopics();
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
      AppThemeService().set(json[AppThemeService().dataKey] ?? AppTheme.light);
      AppColorSchemeService().set(AppColorScheme.values.byName(
          json[AppColorSchemeService().dataKey] ?? AppColorScheme.dynamic));
      SplitLayoutService().set(SplitLayout.values
          .byName(json[SplitLayoutService().dataKey] ?? SplitLayout.uneven));
      PlannedSizeService().set(PlannedSize.values
          .byName(json[PlannedSizeService().dataKey] ?? PlannedSize.normal));
      confirmDeletions = json['confirmDeletions'] ?? true;
      hideTopics = json['hideTopics'] ?? false;
      historyLimit = json['historyLimit'];
      groupHistoryTime = json['groupHistoryTime'] ?? false;

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
      AppThemeService().dataKey: AppThemeService().theme,
      AppColorSchemeService().dataKey: AppColorSchemeService().scheme,
      SplitLayoutService().dataKey: SplitLayoutService().portions,
      PlannedSizeService().dataKey: PlannedSizeService().plannedSize,
      'confirmDeletions': confirmDeletions,
      'hideTopics': hideTopics,
      'historyLimit': historyLimit,
      'groupHistoryTime': groupHistoryTime,
      'playlists': playlists,
    };

    await file.writeAsString(jsonEncode(json));
    return true;
  }
}
