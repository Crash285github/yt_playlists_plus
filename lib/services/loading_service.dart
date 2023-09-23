import 'package:shared_preferences/shared_preferences.dart';

class LoadingService {
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
