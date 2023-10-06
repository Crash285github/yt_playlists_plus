import 'package:flutter/material.dart';

class AppConfig {
  static const mobileMaxWidth = 700.0;

  //?? Desktop-specific
  static const desktopSizeDef = Size(1100, 900);
  static const desktopSizeMin = Size(600, 400);
  static const desktopAlignment = Alignment.center;

  //?? UI
  static const largeCornerRadius = 15.0;
  static const defaultCornerRadius = 10.0;
  static const smallCornerRadius = 4.0;
  static const animationDuration = Duration(milliseconds: 200);
  static const spacing = 16.0;

  //?? Themes
  static const tooltipTheme =
      TooltipThemeData(waitDuration: Duration(seconds: 1));

  static const cardTheme = CardTheme(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
  );

  static const dividerTheme = DividerThemeData(
    indent: 10,
    endIndent: 10,
    space: 2,
  );

  static const snackBarTheme = SnackBarThemeData(
    showCloseIcon: true,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultCornerRadius))),
    insetPadding: EdgeInsets.all(spacing),
    elevation: 0,
  );

  static const buttonPadding =
      MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(spacing));
}
