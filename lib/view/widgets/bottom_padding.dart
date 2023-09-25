import 'dart:io' show Platform;

import 'package:flutter/material.dart';

///Customizable Padding usually for the bottom of `ListViews`,
///to not be obscured by `FloatingActionButtons`
///
///Can be customized to `Windows` & `Android` separately
class BottomPadding extends StatelessWidget {
  ///Height of the padding on `Android` devices
  ///
  ///Default is [kToolbarHeight]
  final double androidHeight;

  ///Height of the padding on `Windows` devices
  ///
  ///Default is [kToolbarHeight]
  final double windowsHeight;

  const BottomPadding({
    super.key,
    this.androidHeight = kToolbarHeight,
    this.windowsHeight = kToolbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: Platform.isAndroid ? androidHeight : windowsHeight);
  }
}
