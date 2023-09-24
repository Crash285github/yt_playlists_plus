import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/services/settings_service/history_limit_service.dart';

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
    int? limit = Provider.of<HistoryLimitService>(context).limit;

    int displaySize = min(size, limit ?? 0);
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