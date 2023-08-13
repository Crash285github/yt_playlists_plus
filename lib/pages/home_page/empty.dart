import 'package:flutter/material.dart';

class HomePageEmpty extends StatelessWidget {
  const HomePageEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "No Playlists... let's find one!",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.grey),
        ),
      )),
    );
  }
}
