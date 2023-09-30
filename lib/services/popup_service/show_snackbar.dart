import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';

extension ShowSnackBar on PopUpService {
  void showSnackBar({
    required BuildContext context,
    required final String message,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Theme.of(context).colorScheme.onError),
        ),
        dismissDirection: DismissDirection.none,
      ),
    );
  }
}
