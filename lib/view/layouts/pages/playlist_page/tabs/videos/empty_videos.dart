import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/config.dart';

class EmptyVideos extends StatelessWidget {
  const EmptyVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConfig.spacing),
          child: Text(
            "This playlist... is empty",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
          ),
        ),
      ),
    );
  }
}
