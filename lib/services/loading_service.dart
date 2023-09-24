import 'package:shared_preferences/shared_preferences.dart';

///Manages data loading
class LoadingService {
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
