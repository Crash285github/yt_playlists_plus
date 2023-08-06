import 'package:flutter/material.dart';

class HomePageSearchButton extends StatelessWidget {
  const HomePageSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context).pushNamed('/search'),
      tooltip: "Search",
      child: const Icon(
        Icons.search,
        size: 30,
      ),
    );
  }
}
