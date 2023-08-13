import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/planned/title_row.dart';
import 'package:yt_playlists_plus/pages/playlist_page/tabs/more/planned/top_handle.dart';

class TopBar {
  static List<Widget> build({
    required PanelController panelController,
    required int plannedSize,
    required Function()? onAddPressed,
  }) {
    return [
      TopHandle(
        //? isPanelOpen always returned false, so had to find a workaround
        onTap: () => panelController.panelPosition.round() == 1
            ? panelController.close()
            : panelController.open(),
      ),
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
