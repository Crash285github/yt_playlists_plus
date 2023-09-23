import 'package:shared_preferences/shared_preferences.dart';

class SavingService {
  static bool _saving = false;

  static Future<bool> save<T>({required String key, required T value}) async {
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
