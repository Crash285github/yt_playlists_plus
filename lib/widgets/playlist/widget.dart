import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/services/popup_service.dart';
import 'package:yt_playlists_plus/constants.dart';
import 'package:yt_playlists_plus/services/reorder_service.dart';
import 'package:yt_playlists_plus/widgets/adatpive_gesture_detector.dart';
import 'package:yt_playlists_plus/widgets/icard.dart';
import 'package:yt_playlists_plus/widgets/playlist/details.dart';
import 'package:yt_playlists_plus/widgets/playlist/progress.dart';
import 'package:yt_playlists_plus/widgets/playlist/status.dart';
import 'package:yt_playlists_plus/widgets/thumbnail.dart';

class PlaylistWidget extends ICardWidget {
  ///The function that runs when you tap on the `PlaylistWidget`
  final void Function()? onTap;

  const PlaylistWidget({
    super.key,
    super.firstOfList = false,
    super.lastOfList = false,
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
            PopUpService.showSnackBar(
                context: context, message: "Couldn't open link.");
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
      onLongOrSecondaryTap: (offset) => PopUpService.showContextMenu(
          context: context, offset: offset, items: copyItems),
      child: Card(
        shape: cardBorder(firstOfList: firstOfList, lastOfList: lastOfList),
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
                          playlist.thumbnailUrl != ""
                              ? Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(3, 3, 10, 3),
                                  child: ThumbnailImage(
                                    thumbnailUrl: playlist.thumbnailUrl,
                                    largeRadius: 13.0,
                                    smallRadius: 4.0,
                                    size: 85.0,
                                    firstOfList: firstOfList,
                                    lastOfList: lastOfList,
                                  ),
                                )
                              : const SizedBox(width: 10),
                          PlaylistDetails(playlist: playlist),
                        ],
                      ),
                    ),
                    PlaylistStatusWidget(status: playlist.status),
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
