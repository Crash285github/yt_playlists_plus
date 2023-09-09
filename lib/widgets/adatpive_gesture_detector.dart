import 'dart:io';
import 'package:flutter/material.dart';

///Has an `onLongOrSecondaryTap`, which fires the Function
///
///when long tapped on android,
///
///or when right clicked on windows
class AdaptiveGestureDetector extends StatelessWidget {
  final Widget? child;
  final Function(Offset offset) onLongOrSecondaryTap;

  const AdaptiveGestureDetector({
    super.key,
    required this.child,
    required this.onLongOrSecondaryTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: Platform.isAndroid
          ? (details) async => onLongOrSecondaryTap(details.globalPosition)
          : null,
      onSecondaryTapUp: Platform.isWindows
          ? (details) async => onLongOrSecondaryTap(details.globalPosition)
          : null,
      child: child,
    );
  }
}
