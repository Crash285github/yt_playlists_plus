import 'package:flutter/material.dart';
import 'theme_constants.dart' as constants;

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

  static int _currentTheme = 0;
  static int get() => _currentTheme;

  ///0 == ApplicationTheme.light
  ///
  ///1 == ApplicationTheme.dark
  static set(int theme) {
    _currentTheme = theme;
    _instance.notifyListeners();
  }
}

//? theme builder
ThemeData themeBuilder({ColorScheme? scheme}) {
  bool isLight = ApplicationTheme.get() == ApplicationTheme.light;

  //fallback
  scheme ??= isLight ? const ColorScheme.light() : const ColorScheme.dark();

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    cardColor: scheme.surface,
    scaffoldBackgroundColor: isLight ? scheme.surfaceVariant : null,
    cardTheme: constants.cardTheme.copyWith(color: scheme.surface),
    tooltipTheme: constants.tooltipTheme,
    appBarTheme:
        isLight ? AppBarTheme(backgroundColor: scheme.surfaceVariant) : null,
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
