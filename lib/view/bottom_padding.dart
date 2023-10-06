import 'dart:io' show Platform;

import 'package:flutter/material.dart';

///A custom SizedBox, with separate height properties for Windows & Android
class AdaptiveHeightBox extends StatelessWidget {
  ///Height of the Box on `Android` devices
  ///
  ///Default is [kToolbarHeight]
  final double androidHeight;

  ///Height of the Box on `Windows` devices
  ///
  ///Default is [kToolbarHeight] + 20
  final double windowsHeight;

  ///The width of the box
  final double? width;

  const AdaptiveHeightBox({
    super.key,
    this.androidHeight = kToolbarHeight + 20,
    this.windowsHeight = kToolbarHeight + 20,
    this.width,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
      height: Platform.isAndroid ? androidHeight : windowsHeight, width: width);
}
