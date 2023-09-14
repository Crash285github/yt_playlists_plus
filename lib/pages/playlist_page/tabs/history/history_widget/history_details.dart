import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class HistoryDetails extends StatelessWidget {
  final String title, author, time, timeago;

  const HistoryDetails({
    super.key,
    required this.title,
    required this.author,
    required this.time,
    required this.timeago,
  });

  final duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Tooltip(
            message: title,
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Row(
            children: [
              Text(
                author,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.grey,
                    ),
              ),
              IgnorePointer(
                ignoring: Persistence.groupHistoryTime,
                child: AnimatedSlide(
                  duration: duration,
                  curve: Curves.decelerate,
                  offset: Persistence.groupHistoryTime
                      ? const Offset(0.5, 0)
                      : const Offset(0, 0),
                  child: AnimatedOpacity(
                    opacity: Persistence.groupHistoryTime ? 0 : 1,
                    duration: duration,
                    curve: Curves.decelerate,
                    child: Tooltip(
                      message: time,
                      child: Text(
                        " • $timeago",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
