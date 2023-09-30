import 'package:flutter/material.dart';

enum AppColorScheme {
  dynamic(color: null, displayName: "Dynamic"),
  mono(color: null, displayName: 'Mono'),
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

  const AppColorScheme({
    required this.displayName,
    required this.color,
  });

  final Color? color;
  final String displayName;

  int toJson() => index;
  static AppColorScheme fromJson(String json) => values[int.parse(json)];
}
