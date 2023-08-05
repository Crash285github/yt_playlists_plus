import 'package:flutter/material.dart';

const buttonPadding = MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(16));

const tooltipTheme = TooltipThemeData(waitDuration: Duration(seconds: 1));

const cardTheme = CardTheme(
  surfaceTintColor: Colors.transparent,
  elevation: 0,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10))),
  clipBehavior: Clip.antiAlias,
  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
);

const expansionTileTheme = ExpansionTileThemeData(
  shape: Border(),
  collapsedShape: Border(),
  tilePadding: EdgeInsets.symmetric(horizontal: 10.0),
);

const dialogTheme = DialogTheme(
  surfaceTintColor: Colors.transparent,
);

const appBarTheme = AppBarTheme(
  surfaceTintColor: Colors.transparent,
);
