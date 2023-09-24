import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/constants.dart' as constants;
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';

///The theme of the Application
///
///It implements the Singleton Design Pattern
class ThemeService extends ChangeNotifier implements SettingService<AppTheme> {
  //Singleton
  static final ThemeService _instance = ThemeService._internal();
  ThemeService._internal();
  factory ThemeService() => _instance;

  AppTheme theme = AppTheme.light;
  bool isAmoled = false;

  @override
  set(AppTheme value) {
    theme = value;
    isAmoled = theme == AppTheme.amoled;
    notifyListeners();
  }

  @override
  String mapKey = 'appTheme';

  @override
  Future<bool> save() async =>
      await SavingService.save<int>(key: mapKey, value: theme.index);

  @override
  Future<void> load() async => set(AppTheme
      .values[await LoadingService.load<int>(key: mapKey, defaultValue: 0)]);

  ///Generates the theme of the application
  ThemeData builder({ColorScheme? scheme}) {
    bool isLight = theme == AppTheme.light;
    bool isAmoled = theme == AppTheme.amoled;

    //fallback schemes
    scheme ??= isLight ? const ColorScheme.light() : const ColorScheme.dark();

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      cardColor: scheme.surface,
      drawerTheme: DrawerThemeData(
          backgroundColor: isAmoled ? Colors.black : scheme.surface,
          elevation: isAmoled ? 3 : 1),
      scaffoldBackgroundColor: isLight
          ? scheme.surfaceVariant
          : isAmoled
              ? Colors.black
              : null,
      cardTheme: constants.cardTheme.copyWith(
          color: isAmoled ? Colors.black : scheme.surface,
          elevation: isAmoled ? 3 : 1),
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
