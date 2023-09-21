import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/constants.dart' as constants;

///The theme of the Application
///
///It implements the Singleton Design Pattern
class ApplicationTheme extends ChangeNotifier {
  //Singleton
  static final ApplicationTheme _instance = ApplicationTheme._internal();
  ApplicationTheme._internal();
  factory ApplicationTheme() => _instance;

  static const int light = 0;
  static const int dark = 1;
  static const int amoled = 2;

  static int _currentTheme = 0;
  static int get() => _currentTheme;

  static set(int theme) {
    _currentTheme = theme;
    _instance.notifyListeners();
  }
}

//? theme builder
ThemeData themeBuilder({ColorScheme? scheme}) {
  bool isLight = ApplicationTheme.get() == ApplicationTheme.light;
  bool isAmoled = ApplicationTheme.get() == ApplicationTheme.amoled;

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
