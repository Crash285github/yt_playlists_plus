import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/app_theme_enum.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';
import 'package:yt_playlists_plus/view/theme_builder.dart';

///Manages the theme of the App
class ThemeService extends ChangeNotifier
    implements SettingService<AppTheme>, StorableService {
  AppTheme theme = Persistence.appTheme;
  bool isAmoled = false;

  @override
  void set(AppTheme value) {
    Persistence.appTheme = theme = value;
    isAmoled = theme == AppTheme.amoled;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.appThemeKey;

  @override
  Future<bool> save() async =>
      await Persistence.save<int>(key: storageKey, value: theme.index);

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
      cardTheme: ThemeBuilder.cardTheme.copyWith(
          color: isAmoled ? Colors.black : scheme.surface,
          elevation: isAmoled ? 3 : 1),
      tooltipTheme: ThemeBuilder.tooltipTheme,
      appBarTheme: isLight
          ? AppBarTheme(backgroundColor: scheme.surfaceVariant)
          : isAmoled
              ? const AppBarTheme(backgroundColor: Colors.black)
              : null,
      tabBarTheme: const TabBarTheme(dividerColor: Colors.transparent),
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(padding: ThemeBuilder.buttonPadding)),
      textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(padding: ThemeBuilder.buttonPadding)),
      dividerTheme: ThemeBuilder.dividerTheme,
      snackBarTheme: ThemeBuilder.snackBarTheme.copyWith(
        backgroundColor: scheme.error,
        closeIconColor: scheme.onError,
      ),
    );
  }

  //__ Singleton
  static final ThemeService _instance = ThemeService._internal();
  ThemeService._internal();
  factory ThemeService() => _instance;
}
