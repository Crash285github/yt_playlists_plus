import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/split_layout_controller.dart';
import 'package:yt_playlists_plus/view/layouts/responsive/single_view.dart';
import 'package:yt_playlists_plus/view/layouts/responsive/split_view.dart';

///Shows `WideLayout` or `NarrowLayout` depending on the size of the screen
///and whether the option is enabled to show SplitView
class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    final bool canSplit = Provider.of<SplitLayoutController>(context).isEnabled;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 700 && canSplit) {
          return const SplitView();
        } else {
          return const SingleView();
        }
      },
    );
  }
}
