import 'package:shared_preferences/shared_preferences.dart';

class LoadingService {
  static Future<int> loadInt(
          {required String key, int defaultValue = 0}) async =>
      (await SharedPreferences.getInstance()).getInt(key) ?? defaultValue;
}
