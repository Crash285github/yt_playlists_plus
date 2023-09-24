import 'package:shared_preferences/shared_preferences.dart';

///Manages data saving
class SavingService {
  //?? is the service currently saving anything
  static bool _saving = false;

  ///Saves data to a Map with [key] and [value]
  ///
  ///Supported types: `int`, `bool`, `List<String>>`
  ///
  ///Unsupported types will throw `UnsupportedError`
  static Future<bool> save<T>({required String key, required T value}) async {
    //?? if every save is awaited, false will never return
    if (_saving) return false;
    _saving = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value is int) {
      return prefs.setInt(key, value).then((_) => _saving = false);
    } else if (value is bool) {
      return prefs.setBool(key, value).then((_) => _saving = false);
    } else if (value is List<String>) {
      return prefs.setStringList(key, value).then((_) => _saving = false);
    } else {
      throw UnsupportedError("Can't save type: ${value.runtimeType}.");
    }
  }
}
