import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/view/pages/playlist_page/tabs/videos/planned/title_row.dart';
import 'package:yt_playlists_plus/view/pages/playlist_page/tabs/videos/planned/top_handle.dart';

class TopBar {
  static List<Widget> build({
    required int plannedSize,
    required Function()? onAddPressed,
    required Function()? onHandleTapped,
  }) {
    return [
      TopHandle(onTap: onHandleTapped),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TitleRow(
          length: plannedSize,
          onAddPressed: onAddPressed,
        ),
      ),
      const Divider(
        indent: 10,
        endIndent: 10,
      ),
    ];
  }
}
