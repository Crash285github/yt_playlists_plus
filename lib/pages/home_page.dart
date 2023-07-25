import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SafeArea(child: Drawer()),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.search),
        iconSize: 30,
        tooltip: "Search",
        onPressed: () => Navigator.of(context).pushNamed('/search'),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("HomePage"),
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
