import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/config.dart';
import 'package:yt_playlists_plus/controller/reorder_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/split_layout_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/drawer/app_drawer.dart';
import 'package:yt_playlists_plus/view/layouts/responsive/single_view.dart';
import 'package:yt_playlists_plus/view/layouts/responsive/split_view.dart';

///Shows `WideLayout` or `NarrowLayout` depending on the size of the screen
///and whether the option is enabled to show SplitView
class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    final bool canSplit = Provider.of<SplitLayoutController>(context).isEnabled;
    final bool canReorder = Provider.of<ReorderController>(context).canReorder;

    return WillPopScope(
      onWillPop: () async {
        if (canReorder) {
          ReorderController().disable();
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: AppConfig.drawerKey,
        drawer: const AppDrawer(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > AppConfig.mobileMaxWidth && canSplit) {
              return const SplitView();
            } else {
              return const SingleView();
            }
          },
        ),
      ),
    );
  }
}
