import 'package:flutter/material.dart';

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

ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light().copyWith(primary: Colors.red),
      drawerTheme: const DrawerThemeData(surfaceTintColor: Colors.transparent),
      cardColor: Colors.grey[200],
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          padding: _iconButtonPadding,
        ),
      ),
      switchTheme: const SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(Colors.black),
      ),
      tooltipTheme: _tooltipTheme,
    );

ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark().copyWith(primary: Colors.red),
      drawerTheme: const DrawerThemeData(surfaceTintColor: Colors.transparent),
      cardColor: Colors.black26,
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          padding: _iconButtonPadding,
        ),
      ),
      switchTheme: const SwitchThemeData(
        thumbColor: MaterialStatePropertyAll(Colors.white),
      ),
      tooltipTheme: _tooltipTheme,
    );

const _iconButtonPadding =
    MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(16));

const _tooltipTheme = TooltipThemeData(waitDuration: Duration(seconds: 1));
