import 'package:flutter/material.dart';

class HomePageSearchButton extends StatelessWidget {
  const HomePageSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      iconSize: 30,
      tooltip: "Search",
      onPressed: () => Navigator.of(context).pushNamed('/search'),
    );
  }
}
