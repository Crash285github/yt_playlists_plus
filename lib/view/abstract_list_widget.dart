import 'package:flutter/material.dart';

///A type of Widget that has optional
///`firstOfList` & `lastOfList` booleans, which
///can be used to customize those elements in a list
abstract class ListWidget extends StatelessWidget {
  ///Is the Widget the first in the list
  final bool firstOfList;

  ///Is the Widget the last in the list
  final bool lastOfList;

  const ListWidget({
    super.key,
    this.firstOfList = false,
    this.lastOfList = false,
  });

  ///Returns a `BorderRadius` based on [firstOfList] & [lastOfList]
  BorderRadius radiusBuilder({
    double strongCorner = 15.0,
    double weakCorner = 4.0,
  }) {
    BorderRadius borders;
    if (firstOfList && lastOfList) {
      borders = BorderRadius.all(Radius.circular(strongCorner));
    } else if (firstOfList) {
      borders = BorderRadius.only(
        topLeft: Radius.circular(strongCorner),
        topRight: Radius.circular(strongCorner),
        bottomLeft: Radius.circular(weakCorner),
        bottomRight: Radius.circular(weakCorner),
      );
    } else if (lastOfList) {
      borders = BorderRadius.only(
        topLeft: Radius.circular(weakCorner),
        topRight: Radius.circular(weakCorner),
        bottomLeft: Radius.circular(strongCorner),
        bottomRight: Radius.circular(strongCorner),
      );
    } else {
      borders = BorderRadius.all(Radius.circular(weakCorner));
    }

    return borders;
  }
}
