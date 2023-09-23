import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

class ColorSchemeService extends ChangeNotifier
    implements SettingService<AppColorScheme> {
  //Singleton
  static final ColorSchemeService _instance = ColorSchemeService._();
  factory ColorSchemeService() => _instance;
  ColorSchemeService._();

  AppColorScheme scheme = AppColorScheme.dynamic;

  @override
  void set(AppColorScheme scheme) {
    this.scheme = scheme;
    notifyListeners();
  }

  @override
  String dataKey = 'colorScheme';

  @override
  Future<bool> save() async =>
      SavingService.saveInt(key: dataKey, value: scheme.index);

  @override
  Future<void> load() async => set(AppColorScheme
      .values[await LoadingService.loadInt(key: dataKey, defaultValue: 0)]);
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
