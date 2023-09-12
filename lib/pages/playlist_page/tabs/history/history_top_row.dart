import 'dart:math';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class HistoryTopRow extends StatelessWidget {
  final Function()? onClearPressed;
  final int size;

  const HistoryTopRow({
    super.key,
    required this.onClearPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    int displaySize = min(size, Persistence.historyLimit ?? 0);
    if (displaySize == 0) displaySize = size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "History ($displaySize)",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextButton(
            onPressed: onClearPressed,
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Clear"), Icon(Icons.clear)],
            ),
          )
        ],
      ),
    );
  }
}
