import 'package:flutter/material.dart';

enum VideoStatus {
  ///The video is both in the Persistence and fetch
  ///
  ///This is also the default state before checking
  ///Icon is error since it should not be seen
  normal(
    displayName: "Normal",
    icon: Icons.error,
    color: Colors.grey,
  ),

  ///The video is pending
  ///
  ///If it was `missing`, it'll be removed from the Playlist on save
  ///If it was `added`, it'll be added to the Playlist on save
  pending(
    displayName: "Pending",
    icon: Icons.circle_outlined,
    color: Colors.blue,
  ),

  ///The video is in the Persistence but not in fetch
  missing(
    displayName: "Missing",
    icon: Icons.remove_circle_outline,
    color: Colors.red,
  ),

  ///The video is in the fetch but not in the Persistence
  added(
    displayName: "Added",
    icon: Icons.add_circle_outline,
    color: Colors.green,
  );

  const VideoStatus({
    required this.displayName,
    required this.icon,
    required this.color,
  });

  final String? displayName;
  final Color? color;
  final IconData? icon;
}
