import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/pages/search_page/search_page.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class HomePageFab extends StatelessWidget {
  const HomePageFab({super.key});

  final searchIcon = const Icon(Icons.search, size: 30);
  final disableReorderIcon = const Icon(Icons.done, size: 30);

  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);
    return FloatingActionButton.extended(
      label: AnimatedSize(
        alignment: Alignment.centerRight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
        child: Persistence.canReorder
            ? const Text("Finish")
            : const SizedBox.shrink(),
      ),
      extendedIconLabelSpacing: Persistence.canReorder ? 8 : 0,
      extendedPadding: const EdgeInsets.all(13),
      tooltip: Persistence.canReorder ? "Finish" : "Search",
      onPressed: Persistence.canReorder
          ? () => Persistence.disableReorder()
          : () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SearchPage()),
              ),
      icon: Persistence.canReorder ? disableReorderIcon : searchIcon,
    );
  }
}
