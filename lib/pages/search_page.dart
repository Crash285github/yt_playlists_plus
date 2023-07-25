import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Search Playlists"),
            centerTitle: true,
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const Placeholder(
                fallbackHeight: 1000,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
