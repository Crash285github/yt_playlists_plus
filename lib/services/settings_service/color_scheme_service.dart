import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

///Manages the application's color scheme
class ColorSchemeService extends ChangeNotifier
    implements SettingService<AppColorScheme>, StorableService {
  AppColorScheme scheme = AppColorScheme.dynamic;

  @override
  void set(AppColorScheme value) {
    scheme = value;
    notifyListeners();
  }

  @override
  String storableKey = 'colorScheme';

  @override
  Future<bool> save() async =>
      Persistence.save<int>(key: storableKey, value: scheme.index);

  @override
  Future<void> load() async => set(AppColorScheme
      .values[await Persistence.load<int>(key: storableKey, defaultValue: 0)]);

  //__ Singleton
  static final ColorSchemeService _instance = ColorSchemeService._();
  factory ColorSchemeService() => _instance;
  ColorSchemeService._();
}

enum AppColorScheme {
  dynamic(color: null, displayName: "Dynamic"),
  mono(color: null, displayName: 'Mono'),
  red(color: Colors.red, displayName: "Red"),
  pink(color: Colors.pink, displayName: "Pink"),
  orange(color: Colors.amber, displayName: "Orange"),
  yellow(color: Colors.yellowAccent, displayName: "Yellow"),
  green(color: Colors.lightGreenAccent, displayName: "Green"),
  cyan(color: Colors.cyanAccent, displayName: "Cyan"),
  blue(color: Colors.lightBlue, displayName: "Blue"),
  indigo(color: Colors.indigoAccent, displayName: "Indigo"),
  purple(color: Colors.purpleAccent, displayName: "Purple"),
  ;

  const AppColorScheme({
    required this.displayName,
    required this.color,
  });

  final Color? color;
  final String displayName;

  String toJson() => name;
  static AppColorScheme fromJson(String json) => values.byName(json);
}
