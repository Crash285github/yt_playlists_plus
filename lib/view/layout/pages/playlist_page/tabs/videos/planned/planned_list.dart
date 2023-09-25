import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/view/layout/pages/playlist_page/tabs/videos/planned/top_bar.dart';
import 'package:yt_playlists_plus/view/layout/pages/playlist_page/tabs/videos/planned/planned_view.dart';

class PlannedList extends StatefulWidget {
  final ScrollController scrollController;
  final Set<String> planned;
  final Function()? onAddPressed;
  final Function(String) onDeletePressed;
  final Function()? onHandleTapped;

  const PlannedList({
    super.key,
    required this.scrollController,
    required this.planned,
    required this.onAddPressed,
    required this.onDeletePressed,
    required this.onHandleTapped,
  });

  @override
  State<PlannedList> createState() => _PlannedListState();
}

class _PlannedListState extends State<PlannedList> {
  @override
  Widget build(BuildContext context) {
    return ListView(controller: widget.scrollController, children: [
      ...TopBar.build(
        plannedSize: widget.planned.length,
        onAddPressed: widget.onAddPressed,
        onHandleTapped: widget.onHandleTapped,
      ),
      ...widget.planned.toList().reversed.map(
            (title) => PlannedView(
              title: title,
              onDeletePressed: () => widget.onDeletePressed(title),
            ),
          ),
    ]);
  }
}
