import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/home_page/appbar.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/drawer.dart';
import 'package:yt_playlists_plus/pages/home_page/empty.dart';
import 'package:yt_playlists_plus/pages/home_page/fab.dart';
import 'package:yt_playlists_plus/pages/home_page/playlists.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/widgets/bottom_padding.dart';

class HomePage extends StatelessWidget {
  final Function(Playlist) onPlaylistTap;

  const HomePage({
    super.key,
    required this.onPlaylistTap,
  });

  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);
    return WillPopScope(
      onWillPop: () async {
        if (Persistence.canReorder) {
          Persistence.disableReorder();
          return false;
        }
        return true;
      },
      child: Scaffold(
        drawer: const HomePageDrawer(),
        body: CustomScrollView(
          slivers: [
            const HomePageAppBar(),
            Persistence.playlists.isEmpty
                ? const HomePageEmpty()
                : HomePagePlaylists(
                    onTap: onPlaylistTap,
                  ),
            if (Persistence.playlists.isNotEmpty)
              const SliverToBoxAdapter(child: BottomPadding())
          ],
        ),
        floatingActionButton: const HomePageFab(),
      ),
    );
  }
}
