import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/config.dart';
import 'package:yt_playlists_plus/controller/searching_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/search_page/search_page.dart';
import 'package:yt_playlists_plus/controller/reorder_controller.dart';

class HomePageFab extends StatelessWidget {
  const HomePageFab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool canReorder = Provider.of<ReorderController>(context).canReorder;

    return FloatingActionButton.extended(
      label: AnimatedSize(
        alignment: Alignment.centerRight,
        duration: AppConfig.animationDuration,
        curve: Curves.decelerate,
        child: canReorder ? const Text("Finish") : const SizedBox.shrink(),
      ),
      extendedIconLabelSpacing: canReorder ? 8 : 0,
      extendedPadding: const EdgeInsets.all(13),
      tooltip: canReorder ? "Finish" : "Search",
      onPressed: canReorder
          ? () => ReorderController().disable()
          : () =>
              Navigator.of(AppConfig.centralKey.currentContext ?? context).push(
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                          create: (context) => SearchingController(),
                          child: const SearchPage(),
                        )),
              ),
      icon: Icon(canReorder ? Icons.done : Icons.search, size: 30),
    );
  }
}
