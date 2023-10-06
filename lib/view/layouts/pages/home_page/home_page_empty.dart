import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/config.dart';

class HomePageEmpty extends StatelessWidget {
  const HomePageEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(AppConfig.spacing),
        child: Text(
          "No Playlists... let's find one!",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
        ),
      )),
    );
  }
}
