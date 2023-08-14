import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';

class PlaylistPageTabBar {
  static TabBar build({
    required BuildContext context,
    required Playlist playlist,
  }) =>
      TabBar(
        isScrollable: true,
        tabs: [
          Tab(
            child: Stack(clipBehavior: Clip.none, children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.change_circle_outlined),
                  SizedBox(width: 10),
                  Text("Changes"),
                ],
              ),
              playlist.status != PlaylistStatus.unChanged &&
                      playlist.status != PlaylistStatus.unChecked &&
                      playlist.status != PlaylistStatus.downloaded
                  ? Positioned(
                      left: 20,
                      top: -5,
                      child: Icon(
                        playlist.status.icon,
                        size: 15,
                        color: playlist.status.color,
                      ),
                    )
                  : const SizedBox.shrink()
            ]),
          ),
          const Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.more_horiz),
                SizedBox(width: 10),
                Text("More"),
              ],
            ),
          ),
          const Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history),
                SizedBox(width: 10),
                Text("History"),
              ],
            ),
          ),
        ],
      );
}
