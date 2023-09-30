import 'package:flutter/material.dart';

enum PlaylistStatus {
  ///Playlist hasn't been downloaded
  ///
  ///Should only appear on the Search Page
  notDownloaded(
    displayName: "Not Downloaded",
    icon: Icons.file_download,
    color: Colors.grey,
  ),

  ///The Playlist data is currently downloading for the first time
  ///
  ///After the download finished, the state will change to `downloaded`
  downloading(
    displayName: "Downloading",
    icon: Icons.file_download,
    color: Colors.green,
  ),

  ///The Playlist has downloaded and is ready for checking
  downloaded(
    displayName: "Downloaded",
    icon: Icons.file_download_done_outlined,
    color: Colors.green,
  ),

  ///The Playlist has not been checked yet
  ///
  ///This is the initial state when constructing a `Playlist`
  unChecked(
    displayName: "Unchecked",
    icon: Icons.refresh,
    color: Colors.grey,
  ),

  ///The Playlist is currently being fetched
  ///
  ///After it finishes, the state should change to `checking`
  ///If fetching fails, the state will change to 'notFound'
  fetching(
    displayName: "Fetching",
    icon: Icons.update,
    color: Colors.teal,
  ),

  ///The Playlist is currently being checked
  ///
  ///After it finishes, the state will change to either
  ///'unchanged' or 'changed'
  checking(
    displayName: "Checking",
    icon: Icons.analytics,
    color: Colors.blue,
  ),

  ///The Playlist has been checked, and nothing has changed
  unChanged(
    displayName: "Unchanged",
    icon: Icons.check,
    color: Colors.green,
  ),

  ///The Playlist has been checked, and there has been some changes
  changed(
    displayName: "Changed",
    icon: Icons.error,
    color: Colors.amber,
  ),

  ///The Playlist itself can't be found on Youtube
  notFound(
    displayName: "Not Found",
    icon: Icons.close,
    color: Colors.red,
  ),

  ///The Playlist has been saved
  saved(
    displayName: "Saved",
    icon: Icons.save,
    color: Colors.lightBlue,
  );

  const PlaylistStatus({
    required this.displayName,
    required this.icon,
    required this.color,
  });

  ///Name of this state that can be displayed on the UI
  final String displayName;

  ///Color of this state
  final Color color;

  ///IconData used to represent this state
  final IconData icon;
}
