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

//? LIGHT THEME
ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light().copyWith(primary: Colors.red),
      drawerTheme: const DrawerThemeData(surfaceTintColor: Colors.transparent),
      cardColor: Colors.grey[300],
      cardTheme: constants.cardTheme.copyWith(color: Colors.grey[300]),
      dialogTheme: constants.dialogTheme,
      tooltipTheme: constants.tooltipTheme,
      appBarTheme: constants.appBarTheme,
      tabBarTheme: TabBarTheme(dividerColor: Colors.grey[300]),
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(padding: constants.buttonPadding)),
      textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(padding: constants.buttonPadding)),
      switchTheme: const SwitchThemeData(
          thumbColor: MaterialStatePropertyAll(Colors.black)),
      expansionTileTheme:
          constants.expansionTileTheme.copyWith(iconColor: Colors.black),
      floatingActionButtonTheme: constants.floatingActionButtonTheme,
      dividerTheme: constants.dividerTheme,
    );

//? DARK THEME
ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark().copyWith(primary: Colors.red),
      drawerTheme: const DrawerThemeData(surfaceTintColor: Colors.transparent),
      cardColor: Colors.grey[900],
      cardTheme: constants.cardTheme.copyWith(color: Colors.grey[900]),
      dialogTheme: constants.dialogTheme,
      tooltipTheme: constants.tooltipTheme,
      appBarTheme: constants.appBarTheme,
      tabBarTheme: TabBarTheme(dividerColor: Colors.grey[900]),
      iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
        padding: constants.buttonPadding,
      )),
      textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(padding: constants.buttonPadding)),
      switchTheme: const SwitchThemeData(
          thumbColor: MaterialStatePropertyAll(Colors.white)),
      expansionTileTheme:
          constants.expansionTileTheme.copyWith(iconColor: Colors.white),
      floatingActionButtonTheme: constants.floatingActionButtonTheme
          .copyWith(foregroundColor: const Color(0xff121212)),
      dividerTheme: constants.dividerTheme,
    );
