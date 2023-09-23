import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/pages/search_page/search_page.dart';
import 'package:yt_playlists_plus/services/reorder_service.dart';

class HomePageFab extends StatelessWidget {
  const HomePageFab({super.key});

  final searchIcon = const Icon(Icons.search, size: 30);
  final disableReorderIcon = const Icon(Icons.done, size: 30);

  @override
  Widget build(BuildContext context) {
    Provider.of<ReorderService>(context).canReorder;
    return FloatingActionButton.extended(
      label: AnimatedSize(
        alignment: Alignment.centerRight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
        child: ReorderService().canReorder
            ? const Text("Finish")
            : const SizedBox.shrink(),
      ),
      extendedIconLabelSpacing: ReorderService().canReorder ? 8 : 0,
      extendedPadding: const EdgeInsets.all(13),
      tooltip: ReorderService().canReorder ? "Finish" : "Search",
      onPressed: ReorderService().canReorder
          ? () => ReorderService().disable()
          : () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SearchPage()),
              ),
      icon: ReorderService().canReorder ? disableReorderIcon : searchIcon,
    );
  }
}
