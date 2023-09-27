import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/enums/planned_size_enum.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/videos/planned/planned_panel.dart';
import 'package:yt_playlists_plus/services/settings_service/planned_size_service.dart';

class PlannedSheetMobile extends StatefulWidget {
  final Playlist playlist;
  const PlannedSheetMobile({
    super.key,
    required this.playlist,
  });

  @override
  State<PlannedSheetMobile> createState() => _PlannedSheetMobileState();
}

class _PlannedSheetMobileState extends State<PlannedSheetMobile> {
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();

  double _opacity = 0.0;
  bool _visible = false;

  double snapSize = 0.2;
  double maxSize = 0.7;

  @override
  void initState() {
    _draggableScrollableController.addListener(() {
      setState(() {
        if (_draggableScrollableController.size <= snapSize + 0.01) {
          _opacity = 0;
          _visible = false;
        } else if (_draggableScrollableController.size >= maxSize - 0.01) {
          _opacity = 0.5;
          _visible = true;
        } else {
          _opacity = (_draggableScrollableController.size - snapSize);
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
    final double height = MediaQuery.of(context).size.height;
    final double minSize = 50 / height;
    final bool canSnap = height * 0.2 > 100;

    return Stack(
      children: [
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
              PlannedSizeService().plannedSize == PlannedSize.normal && canSnap
                  ? snapSize
                  : minSize,
          minChildSize: minSize,
          maxChildSize: maxSize,
          snap: true,
          snapSizes: canSnap ? const [0.2] : null, //?? minSize
          builder: (BuildContext context, ScrollController scrollController) {
            return PlannedPanel(
              planned: widget.playlist.planned,
              scrollController: scrollController,
              onHandleTapped: () {
                if (_draggableScrollableController.size < snapSize) {
                  _draggableScrollableController.animateTo(
                    0.7,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutExpo,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
