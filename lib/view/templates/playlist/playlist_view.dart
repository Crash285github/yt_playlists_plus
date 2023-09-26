import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/services/popup_controller/popup_controller.dart';
import 'package:yt_playlists_plus/services/popup_controller/show_context_menu.dart';
import 'package:yt_playlists_plus/services/popup_controller/show_snackbar.dart';
import 'package:yt_playlists_plus/services/reorder_service.dart';
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
    Playlist playlist = Provider.of<Playlist>(context);

    final List<PopupMenuEntry<dynamic>> copyItems = [
      PopupMenuItem(
        child: const Center(child: Text("Open link")),
        onTap: () async {
          await launchUrl(
                  Uri.parse("https://youtube.com/playlist?list=${playlist.id}"))
              .onError((error, stackTrace) {
            PopUpController()
                .showSnackBar(context: context, message: "Couldn't open link.");
            return false;
          });
        },
      ),
      const PopupMenuDivider(height: 0),
      PopupMenuItem(
        child: const Center(child: Text("Copy title")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: playlist.title));
        },
      ),
      PopupMenuItem(
        child: const Center(child: Text("Copy id")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: playlist.id));
        },
      ),
      PopupMenuItem(
        child: const Center(child: Text("Copy link")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(
              text: "www.youtube.com/playlist?list=${playlist.id}"));
        },
      )
    ];

    return AdaptiveGestureDetector(
      onTrigger: (offset) => PopUpController()
          .showContextMenu(context: context, offset: offset, items: copyItems),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: radiusBuilder()),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (playlist.status == PlaylistStatus.fetching)
              PlaylistProgressIndicator(
                progress: playlist.fetchProgress / 100,
                color: PlaylistStatus.fetching.color,
              ),
            if (playlist.status == PlaylistStatus.downloading)
              PlaylistProgressIndicator(
                progress: playlist.downloadProgress / 100,
                color: PlaylistStatus.downloading.color,
              ),
            Ink(
              child: InkWell(
                onTap: ReorderService().canReorder ? null : onTap,
                child: Row(
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          AnimatedOpacity(
                            duration: const Duration(seconds: 1),
                            opacity: playlist.thumbnailUrl != "" ? 1 : 0,
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 500),
                              child: playlist.thumbnailUrl != ""
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          3, 3, 10, 3),
                                      child: ThumbnailImage(
                                        url: playlist.thumbnailUrl,
                                        strongCorner: 13.0,
                                        weakCorner: 4.0,
                                        size: 85.0,
                                        firstOfList: firstOfList,
                                        lastOfList: lastOfList,
                                      ),
                                    )
                                  : const SizedBox(width: 10, height: 91),
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
