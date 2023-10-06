import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/config.dart';
import 'package:yt_playlists_plus/enums/app_theme_enum.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_controller.dart';

///Manages the theme of the App
class ThemeController extends SettingController<AppTheme>
    implements StorableController {
  AppTheme theme = Persistence.appTheme.value;
  bool isAmoled = false;

  @override
  void set(AppTheme value) {
    theme = value;
    isAmoled = theme == AppTheme.amoled;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.appTheme.key;

  @override
  Future<bool> save() async {
    Persistence.appTheme.value = theme;
    return await Persistence.save<int>(key: storageKey, value: theme.index);
  }

  @override
  Future<void> load() async => set(AppTheme
      .values[await Persistence.load<int>(key: storageKey, defaultValue: 0)]);

  ///Generates a theme based on the given scheme
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
      cardTheme: AppConfig.cardTheme.copyWith(
          color: isAmoled ? Colors.black : scheme.surface,
          elevation: isAmoled ? 3 : 1),
      tooltipTheme: AppConfig.tooltipTheme,
      appBarTheme: isLight
          ? AppBarTheme(backgroundColor: scheme.surfaceVariant)
          : isAmoled
              ? const AppBarTheme(backgroundColor: Colors.black)
              : null,
      tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(padding: AppConfig.buttonPadding)),
      textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(padding: AppConfig.buttonPadding)),
      dividerTheme: AppConfig.dividerTheme,
      snackBarTheme: AppConfig.snackBarTheme.copyWith(
        backgroundColor: scheme.error,
        closeIconColor: scheme.onError,
      ),
    );
  }

  //__ Singleton
  static final ThemeController _instance = ThemeController._internal();
  ThemeController._internal();
  factory ThemeController() => _instance;
}
