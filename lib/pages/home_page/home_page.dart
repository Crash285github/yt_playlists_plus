import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/home_page/appbar.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/drawer.dart';
import 'package:yt_playlists_plus/pages/home_page/empty.dart';
import 'package:yt_playlists_plus/pages/home_page/fab.dart';
import 'package:yt_playlists_plus/pages/home_page/playlists.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/services/reorder_service.dart';
import 'package:yt_playlists_plus/widgets/bottom_padding.dart';

class HomePage extends StatefulWidget {
  final Function(Playlist) onPlaylistTap;

  const HomePage({
    super.key,
    required this.onPlaylistTap,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _controller;
  bool _showFab = true;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.offset == 0 && !_showFab) {
        setState(() {
          _showFab = true;
        });
      } else if (_controller.offset > 80 && _showFab) {
        setState(() {
          _showFab = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);
    return WillPopScope(
      onWillPop: () async {
        if (ReorderService().canReorder) {
          ReorderService().disable();
          return false;
        }
        return true;
      },
      child: Scaffold(
        drawer: const HomePageDrawer(),
        body: CustomScrollView(
          controller: _controller,
          slivers: [
            const HomePageAppBar(),
            Persistence.playlists.isEmpty
                ? const HomePageEmpty()
                : HomePagePlaylists(
                    onTap: widget.onPlaylistTap,
                  ),
            if (Persistence.playlists.isNotEmpty)
              const SliverToBoxAdapter(child: BottomPadding())
          ],
        ),
        floatingActionButton: _showFab || ReorderService().canReorder
            ? const HomePageFab()
            : null,
      ),
    );
  }
}
