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
  bool _isDark = true;

  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);

    return Scaffold(
      drawer: _drawer(context),
      floatingActionButton: _searchButton(context),
      body: _body(),
    );
  }

  _drawer(BuildContext context) => SafeArea(
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
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Dark Mode:"),
                        Switch(
                          value: _isDark,
                          onChanged: (value) {
                            setState(() {
                              _isDark = value;
                            });
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              //About
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed("/about");
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

  _body() => CustomScrollView(
        slivers: [
          customSliverAppBar(title: "HomePage", actions: [
            IconButton(
              padding: const EdgeInsets.all(15),
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                for (var playlist in Persistence().playlists) {
                  await playlist.fetchVideos().drain();
                  playlist.check();
                }
              },
              tooltip: "Refresh all",
            )
          ]),
          SliverList(
            delegate: SliverChildListDelegate(
              Persistence()
                  .playlists
                  .map(
                    (e) => ListenableProvider.value(
                      value: e,
                      child: const PlaylistWidget(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      );

  _searchButton(BuildContext context) => IconButton(
        icon: const Icon(Icons.search),
        iconSize: 30,
        tooltip: "Search",
        onPressed: () => Navigator.of(context).pushNamed('/search'),
      );
}
