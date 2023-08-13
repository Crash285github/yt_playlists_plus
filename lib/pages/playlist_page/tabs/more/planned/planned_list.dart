import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/planned/top_bar.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/planned_widget.dart';

class PlannedList extends StatefulWidget {
  final ScrollController scrollController;
  final PanelController panelController;
  final Set<String> planned;
  final Function()? onAddPressed;
  final Function(String) onDeletePressed;

  const PlannedList({
    super.key,
    required this.scrollController,
    required this.planned,
    required this.panelController,
    required this.onAddPressed,
    required this.onDeletePressed,
  });

  @override
  State<PlannedList> createState() => _PlannedListState();
}

class _PlannedListState extends State<PlannedList> {
  @override
  Widget build(BuildContext context) {
    return ListView(controller: widget.scrollController, children: [
      ...TopBar.build(
        panelController: widget.panelController,
        plannedSize: widget.planned.length,
        onAddPressed: widget.onAddPressed,
      ),
      ...widget.planned.map(
        (title) => PlannedWidget(
          title: title,
          onDeletePressed: () => widget.onDeletePressed(title),
        ),
      ),
      const SizedBox(height: 80),
    ]);
  }
}
