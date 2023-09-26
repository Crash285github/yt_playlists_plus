import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';
import 'package:yt_playlists_plus/view/theme_builder.dart';

///Manages the theme of the App
class ThemeService extends ChangeNotifier
    implements SettingService<AppTheme>, StoreableService {
  AppTheme theme = AppTheme.light;
  bool isAmoled = false;

  @override
  void set(AppTheme value) {
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
