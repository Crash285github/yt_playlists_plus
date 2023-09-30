import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/app_color_scheme_enum.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_service.dart';

///Manages the application's color scheme
class ColorSchemeService extends ChangeNotifier
    implements SettingService<AppColorScheme>, StorableController {
  AppColorScheme scheme = Persistence.colorScheme.value;

  @override
  void set(AppColorScheme value) {
    scheme = value;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.colorScheme.key;

  @override
  Future<bool> save() async =>
      Persistence.save<int>(key: storageKey, value: scheme.index);

  @override
  Future<void> load() async {
    Persistence.colorScheme.value = scheme;
    set(AppColorScheme
        .values[await Persistence.load<int>(key: storageKey, defaultValue: 0)]);
  }

  //__ Singleton
  static final ColorSchemeService _instance = ColorSchemeService._();
  factory ColorSchemeService() => _instance;
  ColorSchemeService._();
}
