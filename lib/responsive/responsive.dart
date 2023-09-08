import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/persistence/split_portions.dart';
import 'package:yt_playlists_plus/responsive/narrow_layout.dart';
import 'package:yt_playlists_plus/responsive/wide_layout.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ApplicationSplitPortions>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700 &&
            ApplicationSplitPortions.get() != SplitPortions.disabled) {
          return ListenableProvider.value(
            value: ApplicationSplitPortions(),
            child: const WideLayout(),
          );
        } else {
          return const NarrowLayout();
        }
      },
    );
  }
}
