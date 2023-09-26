import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

///Manages data saving
class SavingService {
  //?? is the service currently saving anything
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
}
