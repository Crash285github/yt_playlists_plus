import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class PopUpManager {
  //Singleton
  static final PopUpManager _instance = PopUpManager._internal();
  PopUpManager._internal();
  factory PopUpManager() => _instance;

  static Future<String?> openTextFieldDialog({
    required BuildContext context,
    required TextEditingController controller,
    required final String title,
    required final String label,
    required final String submitLabel,
  }) async {
    controller.clear();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          decoration: InputDecoration(
            label: Text(label),
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
          controller: controller,
          onSubmitted: (value) {
            Navigator.of(context).pop(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
            child: Text(submitLabel),
          ),
        ],
      ),
    );
  }

  static Future<bool?> openDeletionConfirmDialog({
    required BuildContext context,
    required Playlist playlist,
  }) async {
    if (!Persistence.confirmDeletions) return true;
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete \"${playlist.title}\"?"),
        content: Text(
          "This will erase all of the playlist's data.",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
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

  static void showSnackBar({
    required BuildContext context,
    required final String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onError,
              ),
        ),
        dismissDirection: DismissDirection.none,
      ),
    );
  }

  static void hideCurrentSnackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
