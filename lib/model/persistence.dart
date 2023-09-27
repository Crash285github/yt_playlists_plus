import 'dart:async';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
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
  static Future<void> loadAll() async {
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

  static Future<void> saveAll() async {
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

  static FutureOr<void> _saving;

  ///Saves data to a Map with [key] and [value]
  ///
  ///Supported types: `int`, `bool`, `List<String>>`
  ///
  ///Unsupported types will throw `UnsupportedError`
  static Future<bool> save<T>({required String key, required T value}) async {
    if (_saving != null) {
      await _saving;
      return save(key: key, value: value);
    }

    //?? lock
    Completer completer = Completer<void>();
    _saving = completer.future;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      return prefs.setInt(key, value).whenComplete(() {
        //?? unlock
        completer.complete();
        _saving = null;
      });
    } else if (value is bool) {
      return prefs.setBool(key, value).whenComplete(() {
        //?? unlock
        completer.complete();
        _saving = null;
      });
    } else if (value is List<String>) {
      return prefs.setStringList(key, value).whenComplete(() {
        //?? unlock
        completer.complete();
        _saving = null;
      });
    } else {
      throw UnsupportedError("Can't save type: ${value.runtimeType}.");
    }
  }

  ///Loads data from a Map with [key]
  ///
  ///If key is not found, [defaultValue] returns
  ///
  ///Supported types: `int`, `bool`, `List<String>>`
  ///
  ///Other types will throw `UnsupportedError`
  static Future<dynamic> load<T>(
      {required String key, required T defaultValue}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (defaultValue is int) {
      return prefs.getInt(key) ?? defaultValue;
    } else if (defaultValue is bool) {
      return prefs.getBool(key) ?? defaultValue;
    } else if (defaultValue is List<String>) {
      return prefs.getStringList(key) ?? defaultValue;
    } else {
      throw UnsupportedError("Can't load type: ${defaultValue.runtimeType}");
    }
  }
}
