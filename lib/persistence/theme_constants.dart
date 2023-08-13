import 'package:flutter/material.dart';

const buttonPadding = MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(16));

const tooltipTheme = TooltipThemeData(waitDuration: Duration(seconds: 1));

const cardTheme = CardTheme(
  surfaceTintColor: Colors.transparent,
  elevation: 0,
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10))),
  clipBehavior: Clip.antiAlias,
  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
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

const floatingActionButtonTheme =
    FloatingActionButtonThemeData(backgroundColor: Colors.red);

const dividerTheme = DividerThemeData(
  indent: 10,
  endIndent: 10,
  space: 2,
);

var snackBarTheme = SnackBarThemeData(
  showCloseIcon: true,
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  insetPadding: const EdgeInsets.all(15),
  elevation: 0,
);

ShapeBorder cardBorder({required bool firstOfList, required bool lastOfList}) {
  double strongCorner = 15.0;
  double weakCorner = 4.0;

  ShapeBorder borders;
  if (firstOfList && lastOfList) {
    borders = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(strongCorner),
      ),
    );
  } else if (firstOfList) {
    borders = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(strongCorner),
        topRight: Radius.circular(strongCorner),
        bottomLeft: Radius.circular(weakCorner),
        bottomRight: Radius.circular(weakCorner),
      ),
    );
  } else if (lastOfList) {
    borders = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(weakCorner),
        topRight: Radius.circular(weakCorner),
        bottomLeft: Radius.circular(strongCorner),
        bottomRight: Radius.circular(strongCorner),
      ),
    );
  } else {
    borders = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(weakCorner),
      ),
    );
  }

  return borders;
}
