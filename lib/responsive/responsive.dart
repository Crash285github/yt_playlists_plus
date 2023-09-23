import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/services/split_layout_service.dart';
import 'package:yt_playlists_plus/responsive/narrow_layout.dart';
import 'package:yt_playlists_plus/responsive/wide_layout.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    final bool canSplit = Provider.of<SplitLayoutService>(context).isEnabled;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700 && canSplit) {
          return const WideLayout();
        } else {
          return const NarrowLayout();
        }
      },
    );
  }
}
