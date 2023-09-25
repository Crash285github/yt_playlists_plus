import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/popup_controller/popup_controller.dart';
import 'package:yt_playlists_plus/services/settings_service/theme_service.dart';

extension ShowContextMenu on PopUpController {
  Future<void> showContextMenu({
    required BuildContext context,
    required Offset offset,
    required List<PopupMenuEntry<dynamic>> items,
  }) async {
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
      items: items,
    );
  }
}
