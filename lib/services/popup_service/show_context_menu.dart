import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/model/video/video_history.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/theme_service.dart';

extension ShowContextMenu on PopUpService {
  Future<void> showContextMenu({
    required BuildContext context,
    required Offset offset,
    Video? video,
    PlaylistController? playlist,
    VideoHistory? history,
  }) async {
    if (video == null && playlist == null && history == null) {
      throw ArgumentError(
          "At least one of these parameters is required: video, playlist, history");
    }
    String id = video?.id ?? playlist?.id ?? history!.id;
    String title = video?.title ?? playlist?.title ?? history!.title;

    String url = playlist != null
        ? "https://www.youtube.com/playlist?list="
        : "https://www.youtube.com/watch?v=";

    final List<PopupMenuEntry<dynamic>> copyItems = [
      PopupMenuItem(
        child: const Center(child: Text("Open")),
        onTap: () async {
          await launchUrl(Uri.parse("$url$id"));
        },
      ),
      const PopupMenuDivider(height: 0),
      PopupMenuItem(
        child: const Center(child: Text("Copy title")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: title));
        },
      ),
      PopupMenuItem(
        child: const Center(child: Text("Copy id")),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: id));
        },
      ),
      PopupMenuItem(
        child: const Center(child: Text("Copy link")),
        onTap: () async {
          await Clipboard.setData(
              ClipboardData(text: "www.youtube.com/watch?v=$id"));
        },
      )
    ];
    await showMenu(
      color: ThemeService().isAmoled
          ? Colors.black
          : Theme.of(context).colorScheme.background,
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      clipBehavior: Clip.antiAlias,
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy,
          MediaQuery.of(context).size.width - offset.dx, 0),
      items: copyItems,
    );
  }
}
