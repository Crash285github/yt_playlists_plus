import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/widgets/widgets_export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);

    return Scaffold(
      drawer: _drawer(),
      floatingActionButton: _searchButton(),
      body: _body(),
    );
  }

  //#region Drawer
  _drawer() => SafeArea(
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //title
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              //About
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/about');
                },
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "About",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                        ),
                        Icon(Icons.info)
                      ],
                    ),
                  ),
                ),
              )
            ],
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
              Persistence()
                  .playlists
                  .map((e) => PlaylistWidget(playlist: e))
                  .toList(),
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
