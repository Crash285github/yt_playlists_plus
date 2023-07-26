import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/widgets/widgets_export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawer(),
      floatingActionButton: _searchButton(),
      body: _body(),
    );
  }

  //#region Drawer
  _drawer() => SafeArea(
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  //#endregion

  //#region Body
  _body() => CustomScrollView(
        slivers: [
          customSliverAppBar("HomePage"),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const PlaylistWidget(),
                const PlaylistWidget(),
                const PlaylistWidget(),
                const PlaylistWidget(),
                const PlaylistWidget(),
                const PlaylistWidget(),
                const PlaylistWidget(),
                const PlaylistWidget(),
                const PlaylistWidget(),
              ],
            ),
          ),
        ],
      );
  //#endregion

  //#region SearchButton
  _searchButton() => IconButton(
        icon: const Icon(Icons.search),
        iconSize: 30,
        tooltip: "Search",
        onPressed: () => Navigator.of(context).pushNamed('/search'),
      );
  //#endregion
}
