import 'package:flutter/material.dart';

enum PlaylistStatus {
  ///The Playlist data is currently downloading for the first time
  ///
  ///After the download finished, the state will change to `downloaded`
  downloading(
    name: "Downloading",
    icon: Icons.file_download,
    color: Colors.green,
  ),

  ///The Playlist has downloaded and is ready for checking
  downloaded(
    name: "Downloaded",
    icon: Icons.file_download_done_outlined,
    color: Colors.green,
  ),

  ///The Playlist has not been checked yet
  ///
  ///This is the initial state when constructing a `Playlist`
  unChecked(
    name: "Unchecked",
    icon: Icons.refresh,
    color: Colors.grey,
  ),

  ///The Playlist is currently being fetched
  ///
  ///After it finishes, the state should change to `checking`
  ///If fetching fails, the state will change to 'notFound'
  fetching(
    name: "Fetching",
    icon: Icons.update,
    color: Colors.teal,
  ),

  ///The Playlist is currently being checked
  ///
  ///After it finishes, the state will change to either
  ///'unchanged' or 'changed'
  checking(
    name: "Checking",
    icon: Icons.analytics,
    color: Colors.blue,
  ),

  ///The Playlist has been checked, and nothing has changed
  unChanged(
    name: "Unchanged",
    icon: Icons.check,
    color: Colors.green,
  ),

  ///The Playlist has been checked, and there has been some changes
  changed(
    name: "Changed",
    icon: Icons.error,
    color: Colors.amber,
  ),

  ///The Playlist itself can't be found on Youtube
  notFound(
    name: "Not Found",
    icon: Icons.close,
    color: Colors.red,
  );

  const PlaylistStatus({
    required this.name,
    required this.icon,
    required this.color,
  });

  ///Stringified name of this state
  final String name;

  ///Color of this state
  final Color color;

  ///IconData used to represent this state
  final IconData icon;
}
