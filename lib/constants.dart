import 'package:flutter/material.dart';

const double pi = 3.1415926535897932;

const buttonPadding = MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(16));

const tooltipTheme = TooltipThemeData(waitDuration: Duration(seconds: 1));

const cardTheme = CardTheme(
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10))),
  clipBehavior: Clip.antiAlias,
  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
);

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

ShapeBorder cardBorder({
  bool firstOfList = false,
  bool lastOfList = false,
  double strongCorner = 15.0,
  double weakCorner = 4.0,
}) {
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
