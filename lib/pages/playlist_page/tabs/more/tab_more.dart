import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/empty.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/planned/planned_panel.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/videos_list.dart';
import 'package:yt_playlists_plus/persistence/initial_planned_size.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class MoreTab extends StatefulWidget {
  final Playlist playlist;

  const MoreTab({
    super.key,
    required this.playlist,
  });

  @override
  State<MoreTab> createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();

  double _opacity = 0.0;
  bool _visible = false;

  double minSize = 0.2;
  double maxSize = 0.7;

  @override
  void initState() {
    _draggableScrollableController.addListener(() {
      setState(() {
        if (_draggableScrollableController.size <= minSize + 0.01) {
          _opacity = 0;
          _visible = false;
        } else if (_draggableScrollableController.size >= maxSize - 0.01) {
          _opacity = 0.5;
          _visible = true;
        } else {
          _opacity = (_draggableScrollableController.size - minSize);
          _visible = true;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _draggableScrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        widget.playlist.videos.isEmpty
            ? const EmptyVideos()
            : VideosList(videos: widget.playlist.videos),
        Visibility(
          visible: _visible,
          child: Opacity(
            opacity: _opacity,
            child: Container(
              color: Colors.black,
            ),
          ),
        ),
        DraggableScrollableSheet(
          controller: _draggableScrollableController,
          initialChildSize:
              Persistence.initialPlannedSize == InitialPlannedSize.normal
                  ? minSize
                  : 0.05,
          minChildSize: 0.05,
          maxChildSize: maxSize,
          snap: true,
          snapSizes: const [0.2], //? minSize
          builder: (BuildContext context, ScrollController scrollController) {
            return PlannedPanel(
              planned: widget.playlist.planned,
              scrollController: scrollController,
              onHandleTapped: () {
                if (_draggableScrollableController.size <= 0.051) {
                  _draggableScrollableController.animateTo(
                    0.7,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.decelerate,
                  );
                }
              },
            );
          },
        ),
      ]),
    );
  }
}
