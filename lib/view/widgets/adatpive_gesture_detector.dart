import 'dart:io';
import 'package:flutter/material.dart';

///Platform-specific `GestureDetector` with a single [onTrigger] function
///
///Windows: [onTrigger] will trigger on right-click
///
///Andoird: [onTrigger] will trigger on long-press
class AdaptiveGestureDetector extends StatelessWidget {
  ///The widget below this widget in the tree.
  ///
  ///This widget can only have one child. To lay out multiple children,
  ///let this widget's child be a widget such as [Row], [Column], or [Stack],
  ///which have a children property, and then provide the children to that widget.
  final Widget? child;

  ///Called when the platform-specific trigger occurs
  final Function(Offset offset) onTrigger;

  const AdaptiveGestureDetector({
    super.key,
    required this.child,
    required this.onTrigger,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: Platform.isAndroid
          ? (details) async => onTrigger(details.globalPosition)
          : null,
      onSecondaryTapUp: Platform.isWindows
          ? (details) async => onTrigger(details.globalPosition)
          : null,
      child: child,
    );
  }
}
