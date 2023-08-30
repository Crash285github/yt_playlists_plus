import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/pages/home_page/disable_reorder_button.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/drawer.dart';
import 'package:yt_playlists_plus/pages/home_page/body.dart';
import 'package:yt_playlists_plus/pages/home_page/search_button.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);
    return Scaffold(
      drawer: const HomePageDrawer(),
      body: const HomePageBody(),
      floatingActionButton: Persistence.canReorder
          ? const DisableReorderButton()
          : const HomePageSearchButton(),
    );
  }
}
