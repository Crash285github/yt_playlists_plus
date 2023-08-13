import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/history/history_top_row.dart';

class EmptyHistory extends StatelessWidget {
  const EmptyHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: HistoryTopRow(
            onClearPressed: null,
          ),
        ),
        const Divider(),
        Expanded(
            child: Center(
          child: Text(
            "History is empty.",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.grey),
          ),
        ))
      ],
    );
  }
}
