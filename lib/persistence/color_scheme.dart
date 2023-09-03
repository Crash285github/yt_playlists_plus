import 'package:flutter/material.dart';

class ApplicationColorScheme extends ChangeNotifier {
  //Singleton
  static final ApplicationColorScheme _instance =
      ApplicationColorScheme._internal();
  ApplicationColorScheme._internal();
  factory ApplicationColorScheme() => _instance;

  static ApplicationColor _currentColorScheme = ApplicationColor.dynamic;
  static ApplicationColor get() => _currentColorScheme;

  static set(ApplicationColor scheme) {
    _currentColorScheme = scheme;
    _instance.notifyListeners();
  }
}

enum ApplicationColor {
  dynamic(color: null, displayName: "Dynamic"),
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

  const ApplicationColor({
    required this.displayName,
    required this.color,
  });

  final Color? color;
  final String displayName;
}
