import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/popup_controller/popup_controller.dart';
import 'package:yt_playlists_plus/services/settings_service/confirm_deletions_service.dart';

extension OpenConfirmDialog on PopUpController {
  Future<bool?> openConfirmDialog({
    required BuildContext context,
    required String title,
    String? content,
  }) async {
    if (!ConfirmDeletionsService().confirmDeletions) return true;

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: content != null
            ? Text(
                content,
                style: Theme.of(context).textTheme.bodyLarge,
              )
            : null,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
