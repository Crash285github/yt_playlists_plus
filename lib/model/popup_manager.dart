import 'package:flutter/material.dart';

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

  static void showSnackBar({
    required BuildContext context,
    required final String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        dismissDirection: DismissDirection.none,
      ),
    );
  }

  static void hideCurrentSnackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
