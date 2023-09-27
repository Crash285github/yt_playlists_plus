import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yt_playlists_plus/services/popup_controller/popup_controller.dart';

extension OpenTextFieldDialog on PopUpController {
  Future<String?> openTextFieldDialog({
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
}
