import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/planned/top_bar.dart';

class EmptyPlanned extends StatefulWidget {
  final ScrollController scrollController;
  final Function()? onAddPressed;
  final Function()? onHandleTapped;

  const EmptyPlanned({
    super.key,
    required this.onAddPressed,
    required this.scrollController,
    required this.onHandleTapped,
  });

  @override
  State<EmptyPlanned> createState() => _EmptyPlannedState();
}

class _EmptyPlannedState extends State<EmptyPlanned> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.scrollController,
      children: [
        ...TopBar.build(
          plannedSize: 0,
          onAddPressed: widget.onAddPressed,
          onHandleTapped: widget.onHandleTapped,
        ),
        Center(
            child: Text(
          "Nothing in planned...",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
        ))
      ],
    );
  }
}
