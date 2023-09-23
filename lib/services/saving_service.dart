import 'package:shared_preferences/shared_preferences.dart';

class SavingService {
  static bool _saving = false;

  static Future<bool> saveInt({required String key, required int value}) async {
    if (_saving) return false;
    _saving = true;
    return (await SharedPreferences.getInstance())
        .setInt(key, value)
        .then((_) => _saving = false);
  }
}
