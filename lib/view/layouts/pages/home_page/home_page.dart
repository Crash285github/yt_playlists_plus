import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/home_page/home_page_appbar.dart';
import 'package:yt_playlists_plus/view/layouts/pages/home_page/home_page_empty.dart';
import 'package:yt_playlists_plus/view/layouts/pages/home_page/home_page_fab.dart';
import 'package:yt_playlists_plus/view/layouts/pages/home_page/home_page_playlists.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';
import 'package:yt_playlists_plus/controller/reorder_controller.dart';
import 'package:yt_playlists_plus/view/bottom_padding.dart';

class HomePage extends StatefulWidget {
  final Function(PlaylistController) onPlaylistTap;

  const HomePage({
    super.key,
    required this.onPlaylistTap,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController controller;
  bool showFab = true;

  @override
  void initState() {
    controller = ScrollController();
    controller.addListener(() {
      if (controller.offset == 0 && !showFab) {
        setState(() {
          showFab = true;
        });
      } else if (controller.offset >= kToolbarHeight && showFab) {
        setState(() {
          showFab = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<PlaylistController> playlists =
        Provider.of<PlaylistsController>(context).playlists;
    bool canReorder = Provider.of<ReorderController>(context).canReorder;

    return Scaffold(
      body: CustomScrollView(
        controller: controller,
        slivers: [
          const HomePageAppBar(),
          playlists.isEmpty
              ? const HomePageEmpty()
              : HomePagePlaylists(onTap: widget.onPlaylistTap),
          if (playlists.isNotEmpty)
            const SliverToBoxAdapter(child: AdaptiveHeightBox())
        ],
      ),
      floatingActionButton: showFab || canReorder ? const HomePageFab() : null,
    );
  }
}
