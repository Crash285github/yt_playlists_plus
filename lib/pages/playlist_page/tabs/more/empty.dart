import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/more_top_row.dart';

class EmptyVideos extends StatelessWidget {
  const EmptyVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MoreTopRow(length: 0),
        const Divider(),
        Expanded(
            child: Center(
          child: Text(
            "This playlist... is empty",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.grey),
          ),
        )),
      ],
    );
  }
}
