import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/responsive/narrow_layout.dart';
import 'package:yt_playlists_plus/responsive/wide_layout.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700) {
          return const WideLayout();
        } else {
          return const NarrowLayout();
        }
      },
    );
  }
}
