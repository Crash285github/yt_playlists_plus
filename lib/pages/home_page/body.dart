import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/pages/home_page/appbar.dart';
import 'package:yt_playlists_plus/pages/home_page/empty.dart';
import 'package:yt_playlists_plus/pages/home_page/playlists.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/widgets/bottom_padding.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);

    return CustomScrollView(
      slivers: [
        const HomePageAppBar(),
        Persistence.playlists.isEmpty
            ? const HomePageEmpty()
            : const HomePagePlaylists(),
        Persistence.playlists.isEmpty
            ? const SliverToBoxAdapter(child: SizedBox.shrink())
            : const SliverToBoxAdapter(child: BottomPadding())
      ],
    );
  }
}
