import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/config.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/enums/playlist_status.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/services/popup_service/show_context_menu.dart';
import 'package:yt_playlists_plus/controller/reorder_controller.dart';
import 'package:yt_playlists_plus/view/templates/adatpive_gesture_detector.dart';
import 'package:yt_playlists_plus/view/abstract_list_widget.dart';
import 'package:yt_playlists_plus/view/templates/playlist/playlist_details.dart';
import 'package:yt_playlists_plus/view/templates/playlist/playlist_progress_indicator.dart';
import 'package:yt_playlists_plus/view/templates/playlist/playlist_status_view.dart';
import 'package:yt_playlists_plus/view/templates/thumbnail.dart';

class PlaylistView extends ListWidget {
  ///The function that runs when you tap on the `PlaylistWidget`
  final void Function()? onTap;

  const PlaylistView({
    super.key,
    super.firstOfList,
    super.lastOfList,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    PlaylistController playlist = Provider.of<PlaylistController>(context);

    return AdaptiveGestureDetector(
      onTrigger: (offset) => PopUpService().showContextMenu(
          context: context, offset: offset, playlist: playlist),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: radiusBuilder()),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (playlist.status == PlaylistStatus.fetching ||
                playlist.status == PlaylistStatus.downloading)
              PlaylistProgressIndicator(
                progress: playlist.progress / 100,
                color: playlist.status.color,
              ),
            Ink(
              child: InkWell(
                onTap: ReorderController().canReorder ? null : onTap,
                child: Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          AnimatedOpacity(
                            duration: AppConfig.animationDuration * 5,
                            curve: Curves.decelerate,
                            opacity: playlist.thumbnailUrl != "" ? 1 : 0,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: AnimatedSize(
                                duration: AppConfig.animationDuration * 2,
                                curve: Curves.decelerate,
                                child: playlist.thumbnailUrl != ""
                                    ? ThumbnailImage(
                                        url: playlist.thumbnailUrl,
                                        size: 85.0,
                                        firstOfList: firstOfList,
                                        lastOfList: lastOfList,
                                      )
                                    : const SizedBox(width: 0, height: 91),
                              ),
                            ),
                          ),
                          PlaylistDetails(playlist: playlist),
                        ],
                      ),
                    ),
                    PlaylistStatusView(status: playlist.status),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
