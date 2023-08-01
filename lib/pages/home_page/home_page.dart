import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer.dart';
import 'package:yt_playlists_plus/pages/home_page/body.dart';
import 'package:yt_playlists_plus/pages/home_page/search_button.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);

    return const Scaffold(
      drawer: HomePageDrawer(),
      body: HomePageBody(),
      floatingActionButton: HomePageSearchButton(),
    );
  }
}
