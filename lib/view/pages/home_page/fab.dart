import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/services/search_service.dart';
import 'package:yt_playlists_plus/view/pages/search_page/search_page.dart';
import 'package:yt_playlists_plus/services/reorder_service.dart';

class HomePageFab extends StatelessWidget {
  const HomePageFab({super.key});

  final searchIcon = const Icon(Icons.search, size: 30);
  final disableReorderIcon = const Icon(Icons.done, size: 30);

  @override
  Widget build(BuildContext context) {
    final bool canReorder = Provider.of<ReorderService>(context).canReorder;

    return FloatingActionButton.extended(
      label: AnimatedSize(
        alignment: Alignment.centerRight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
        child: canReorder ? const Text("Finish") : const SizedBox.shrink(),
      ),
      extendedIconLabelSpacing: canReorder ? 8 : 0,
      extendedPadding: const EdgeInsets.all(13),
      tooltip: canReorder ? "Finish" : "Search",
      onPressed: canReorder
          ? () => ReorderService().disable()
          : () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                          create: (context) => SearchService(),
                          child: const SearchPage(),
                        )),
              ),
      icon: canReorder ? disableReorderIcon : searchIcon,
    );
  }
}
