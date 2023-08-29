import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/more_top_row.dart';

class EmptyVideos extends StatelessWidget {
  final MoreTopRow topRow;
  const EmptyVideos({
    super.key,
    required this.topRow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        topRow,
        const Divider(),
        Expanded(
            child: Center(
          child: Text(
            "This playlist... is empty",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
          ),
        )),
      ],
    );
  }
}
