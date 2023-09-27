import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yt_playlists_plus/enums/app_color_scheme_enum.dart';
import 'package:yt_playlists_plus/enums/app_theme_enum.dart';
import 'package:yt_playlists_plus/enums/planned_size_enum.dart';
import 'package:yt_playlists_plus/enums/split_layout_enum.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';

///Data management
class Persistence {
  //__ data keys
  static const String appThemeKey = 'appTheme',
      colorSchemeKey = 'appColorScheme',
      splitLayoutKey = 'splitLayout',
      plannedSizeKey = 'plannedSize',
      confirmDeletionsKey = 'confirmDeletions',
      hideTopicsKey = 'hideTopics',
      groupHistoryKey = 'groupHistory',
      historyLimitKey = 'historyLimit',
      playlistsKey = 'playlists';

  //__ data default values
  static AppTheme appTheme = AppTheme.light;
  static AppColorScheme colorScheme = AppColorScheme.blue;
  static SplitLayout splitLayout = SplitLayout.uneven;
  static PlannedSize plannedSize = PlannedSize.normal;
  static bool confirmDeletions = true;
  static bool hideTopics = true;
  static bool groupHistory = false;
  static int? historyLimit;
  static List<Playlist> playlists = [];

  //?? lock saving
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

  static bool _importing = false;
  static Future<Map?> import() async {
    if (_importing) return null;
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
      return jsonDecode(await file.readAsString());
    }

    return null;
  }

  static Future<bool> export() async {
    String? dir = await FilePicker.platform.getDirectoryPath();
    if (dir == null) return false; //?? cancelled

    final File file =
        File('$dir/export${DateTime.now().millisecondsSinceEpoch}.json');

    final json = {
      appThemeKey: appTheme,
      colorSchemeKey: colorScheme,
      splitLayoutKey: splitLayout,
      plannedSizeKey: plannedSize,
      confirmDeletionsKey: confirmDeletions,
      hideTopicsKey: hideTopics,
      historyLimitKey: historyLimit,
      groupHistoryKey: groupHistory,
      playlistsKey: playlists,
    };

    await file.writeAsString(jsonEncode(json));
    return true;
  }
}
