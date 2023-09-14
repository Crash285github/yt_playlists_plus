import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class HistoryGroupTime extends StatelessWidget {
  final String time;
  const HistoryGroupTime({
    super.key,
    required this.time,
  });

  final duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);

    return AnimatedContainer(
      height: Persistence.groupHistoryTime ? 25 : 0,
      duration: duration,
      child: AnimatedOpacity(
        duration: duration,
        curve: Curves.decelerate,
        opacity: Persistence.groupHistoryTime ? 1 : 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            time,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.5)),
          ),
        ),
      ),
    );
  }
}
