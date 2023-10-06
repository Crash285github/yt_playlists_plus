import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/config.dart';

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
    double largeCorner = AppConfig.largeCornerRadius,
    double smallCorner = AppConfig.smallCornerRadius,
  }) {
    BorderRadius borders;
    if (firstOfList && lastOfList) {
      borders = BorderRadius.all(Radius.circular(largeCorner));
    } else if (firstOfList) {
      borders = BorderRadius.only(
        topLeft: Radius.circular(largeCorner),
        topRight: Radius.circular(largeCorner),
        bottomLeft: Radius.circular(smallCorner),
        bottomRight: Radius.circular(smallCorner),
      );
    } else if (lastOfList) {
      borders = BorderRadius.only(
        topLeft: Radius.circular(smallCorner),
        topRight: Radius.circular(smallCorner),
        bottomLeft: Radius.circular(largeCorner),
        bottomRight: Radius.circular(largeCorner),
      );
    } else {
      borders = BorderRadius.all(Radius.circular(smallCorner));
    }

    return borders;
  }
}
