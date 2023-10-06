import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/config.dart';
import 'package:yt_playlists_plus/enums/playlist_status.dart';

class PlaylistTabBar extends StatelessWidget {
  final PlaylistStatus status;

  const PlaylistTabBar({
    super.key,
    required this.status,
  });

  final double _tabGap = 10.0;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      splashBorderRadius: BorderRadius.circular(AppConfig.defaultCornerRadius),
      tabs: [
        Tab(
          child: Stack(clipBehavior: Clip.none, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.change_circle_outlined),
                SizedBox(width: _tabGap),
                const Text("Changes"),
              ],
            ),
            if (status != PlaylistStatus.unChanged &&
                status != PlaylistStatus.unChecked &&
                status != PlaylistStatus.downloaded &&
                status != PlaylistStatus.saved)
              Positioned(
                left: 20,
                top: -5,
                child: Icon(
                  status.icon,
                  size: 15,
                  color: status.color,
                ),
              )
          ]),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.list),
              SizedBox(width: _tabGap),
              const Text("Videos"),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.history),
              SizedBox(width: _tabGap),
              const Text("History"),
            ],
          ),
        ),
      ],
    );
  }
}
