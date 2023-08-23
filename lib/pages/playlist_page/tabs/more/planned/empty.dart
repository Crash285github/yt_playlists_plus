import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/planned/top_bar.dart';

class EmptyPlanned extends StatefulWidget {
  final PanelController panelController;
  final Set<String> planned;
  final Function()? onAddPressed;

  const EmptyPlanned({
    super.key,
    required this.panelController,
    required this.planned,
    required this.onAddPressed,
  });

  @override
  State<EmptyPlanned> createState() => _EmptyPlannedState();
}

class _EmptyPlannedState extends State<EmptyPlanned> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...TopBar.build(
          panelController: widget.panelController,
          plannedSize: widget.planned.length,
          onAddPressed: widget.onAddPressed,
        ),
        Expanded(
            child: Center(
          child: Text(
            "Nothing in planned...",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
          ),
        ))
      ],
    );
  }
}
