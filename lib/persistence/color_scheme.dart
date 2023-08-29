import 'package:flutter/material.dart';

enum ApplicationColor {
  dynamic(color: null, displayName: "Dynamic"),
  red(color: Colors.red, displayName: "Red"),
  orange(color: Colors.orange, displayName: "Orange"),
  yellow(color: Colors.yellow, displayName: "Yellow"),
  green(color: Colors.lightGreenAccent, displayName: "Green"),
  cyan(color: Colors.cyanAccent, displayName: "Cyan"),
  blue(color: Colors.lightBlue, displayName: "Blue"),
  purple(color: Colors.purpleAccent, displayName: "Purple"),
  indigo(color: Colors.indigoAccent, displayName: "Indigo");

  const ApplicationColor({
    required this.displayName,
    required this.color,
  });

  final Color? color;
  final String displayName;
}
