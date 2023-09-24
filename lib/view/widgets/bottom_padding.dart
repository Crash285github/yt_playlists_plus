import 'dart:io' show Platform;

import 'package:flutter/material.dart';

///Used at the end of ListViews so that the floating button doesn't obscure
class BottomPadding extends StatelessWidget {
  final double androidHeight;
  final double windowsHeight;
  const BottomPadding(
      {super.key, this.androidHeight = 80, this.windowsHeight = 80});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: Platform.isAndroid ? androidHeight : windowsHeight);
  }
}
