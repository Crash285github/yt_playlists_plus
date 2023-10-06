import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yt_playlists_plus/config.dart';

class PlannedTitle extends StatelessWidget {
  final String title;
  final Function onDeletePressed;
  const PlannedTitle({
    super.key,
    required this.title,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppConfig.spacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Tooltip(
              message: title,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: title));
                },
                icon: const Icon(Icons.copy_outlined),
                color: Colors.grey,
                tooltip: "Copy",
              ),
              IconButton(
                onPressed: () => onDeletePressed(),
                icon: const Icon(Icons.remove),
                color: Colors.red,
                tooltip: "Remove",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
