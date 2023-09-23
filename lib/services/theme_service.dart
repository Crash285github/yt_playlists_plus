import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/constants.dart' as constants;
import 'package:yt_playlists_plus/services/abstract_setting_service.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';

///The theme of the Application
///
///It implements the Singleton Design Pattern
class AppThemeService extends ChangeNotifier
    implements SettingService<AppTheme> {
  //Singleton
  static final AppThemeService _instance = AppThemeService._internal();
  AppThemeService._internal();
  factory AppThemeService() => _instance;

  AppTheme theme = AppTheme.light;

  @override
  set(AppTheme theme) {
    this.theme = theme;
    _instance.notifyListeners();
  }

  @override
  String dataKey = 'appTheme';

  @override
  Future<bool> save() async =>
      SavingService.saveInt(key: dataKey, value: theme.index);

  @override
  Future<void> load() async => set(AppTheme
      .values[await LoadingService.loadInt(key: dataKey, defaultValue: 0)]);
}

enum AppTheme {
  light(displayName: 'Light'),
  dark(displayName: 'Dark'),
  amoled(displayName: 'Amoled'),
  ;

  const AppTheme({required this.displayName});

  final String displayName;

  String toJson() => name;
  static AppTheme fromJson(String json) => values.byName(json);
}

//? theme builder
ThemeData themeBuilder({ColorScheme? scheme}) {
  bool isLight = AppThemeService().theme == AppTheme.light;
  bool isAmoled = AppThemeService().theme == AppTheme.amoled;

  //fallback
  scheme ??= isLight ? const ColorScheme.light() : const ColorScheme.dark();

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    cardColor: scheme.surface,
    drawerTheme: DrawerThemeData(
        backgroundColor: isAmoled ? Colors.black : scheme.surface),
    scaffoldBackgroundColor: isLight
        ? scheme.surfaceVariant
        : isAmoled
            ? Colors.black
            : null,
    cardTheme: constants.cardTheme
        .copyWith(color: isAmoled ? Colors.black : scheme.surface),
    tooltipTheme: constants.tooltipTheme,
    appBarTheme: isLight
        ? AppBarTheme(backgroundColor: scheme.surfaceVariant)
        : isAmoled
            ? const AppBarTheme(backgroundColor: Colors.black)
            : null,
    tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(padding: constants.buttonPadding)),
    textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(padding: constants.buttonPadding)),
    dividerTheme: constants.dividerTheme,
    snackBarTheme: constants.snackBarTheme.copyWith(
      backgroundColor: scheme.error,
      closeIconColor: scheme.onError,
    ),
  );
}
