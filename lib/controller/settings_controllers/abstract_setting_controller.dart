import 'package:flutter/foundation.dart';

abstract class SettingController<T> extends ChangeNotifier {
  void set(T value);
}
