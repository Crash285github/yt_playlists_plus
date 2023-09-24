import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yt_playlists_plus/services/settings_service/confirm_deletions_service.dart';
import 'package:yt_playlists_plus/services/settings_service/theme_service.dart';

class PopUpService {
  static Future<String?> openTextFieldDialog({
    required BuildContext context,
    required TextEditingController controller,
    required final String title,
    final String? label,
    final String submitLabel = "Submit",
    final String cancelLabel = "Cancel",
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
  }) async {
    controller.clear();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          decoration: InputDecoration(
            label: label == null ? null : Text(label),
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          controller: controller,
          onSubmitted: (value) {
            Navigator.of(context).pop(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(null);
            },
            child: Text(cancelLabel),
          ),
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

  static Future<bool?> openConfirmDialog({
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

  static void showSnackBar({
    required BuildContext context,
    required final String message,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
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

  static Future<void> showContextMenu({
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
