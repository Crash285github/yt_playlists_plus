import 'package:flutter/material.dart';

class PlaylistProgressIndicator extends StatefulWidget {
  final double progress;
  final Color? color;
  const PlaylistProgressIndicator({
    super.key,
    required this.progress,
    this.color,
  });

  @override
  State<PlaylistProgressIndicator> createState() =>
      _PlaylistProgressIndicatorState();
}

class _PlaylistProgressIndicatorState extends State<PlaylistProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: widget.progress),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return LinearProgressIndicator(
          backgroundColor: Colors.transparent,
          value: value,
          color: widget.color?.withOpacity(0.4) ??
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
        );
      },
    );
  }
}
