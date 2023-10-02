import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';
import 'package:yt_playlists_plus/enums/app_color_scheme_enum.dart';
import 'package:yt_playlists_plus/enums/app_theme_enum.dart';
import 'package:yt_playlists_plus/enums/planned_size_enum.dart';
import 'package:yt_playlists_plus/enums/split_layout_enum.dart';
import 'package:yt_playlists_plus/model/playlist.dart';
import 'package:yt_playlists_plus/model/storable_data.dart';

///Data management
class Persistence {
  //?? sync lock
  static final Lock _lock = Lock();

  //__ data keys & default values
  static StorableData<AppTheme> appTheme =
      StorableData(key: 'appTheme', value: AppTheme.light);

  static StorableData<AppColorScheme> colorScheme =
      StorableData(key: 'appColorScheme', value: AppColorScheme.blue);

  static StorableData<SplitLayout> splitLayout =
      StorableData(key: 'splitLayout', value: SplitLayout.uneven);

  static StorableData<PlannedSize> plannedSize =
      StorableData(key: 'plannedSize', value: PlannedSize.normal);

  static StorableData<bool> confirmDeletions =
      StorableData(key: 'confirmDeletions', value: true);

  static StorableData<bool> hideTopics =
      StorableData(key: 'hideTopics', value: true);

  static StorableData<bool> groupHistory =
      StorableData(key: 'groupHistory', value: true);

  static StorableData<int?> historyLimit =
      StorableData(key: 'historyLimit', value: null);

  static StorableData<List<Playlist>> playlists =
      StorableData(key: 'playlists', value: []);

  ///Saves data to a Map with [key] and [value]
  ///
  ///Supported types: `int`, `bool`, `List<String>>`
  ///
  ///Unsupported types will throw `UnsupportedError`
  static Future<bool> save<T>({required String key, required T value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return _lock.synchronized(() {
      if (value is int) {
        return prefs.setInt(key, value);
      } else if (value is bool) {
        return prefs.setBool(key, value);
      } else if (value is List<String>) {
        return prefs.setStringList(key, value);
      } else {
        throw UnsupportedError("Can't save type: ${value.runtimeType}.");
      }
    });
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
      appTheme.key: appTheme.value,
      colorScheme.key: colorScheme.value,
      splitLayout.key: splitLayout.value,
      plannedSize.key: plannedSize.value,
      confirmDeletions.key: confirmDeletions.value,
      hideTopics.key: hideTopics.value,
      historyLimit.key: historyLimit.value,
      groupHistory.key: groupHistory.value,
      playlists.key: playlists.value,
    };

    await file.writeAsString(jsonEncode(json));
    return true;
  }
}
