import 'dart:io' show Platform;

import 'package:flutter/material.dart';

///Customizable Padding usually for the bottom of `ListViews`,
///to not be obscured by `FloatingActionButtons`
///
///Can be customized to `Windows` & `Android` separately
class BottomPadding extends StatelessWidget {
  ///Height of the padding on `Android` devices
  ///
  ///Default is 80
  final double androidHeight;

  ///Height of the padding on `Windows` devices
  ///
  ///Default is 80
  final double windowsHeight;

  const BottomPadding({
    super.key,
    this.androidHeight = 80,
    this.windowsHeight = 80,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: Platform.isAndroid ? androidHeight : windowsHeight);
  }
}
