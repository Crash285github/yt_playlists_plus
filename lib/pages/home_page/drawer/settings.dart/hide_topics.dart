import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class HideTopicsSwitch extends StatefulWidget {
  const HideTopicsSwitch({super.key});

  @override
  State<HideTopicsSwitch> createState() => _HideTopicsSwitchState();
}

class _HideTopicsSwitchState extends State<HideTopicsSwitch> {
  bool _hideTopics = Persistence.hideTopics;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _hideTopics,
      title: const Text("Hide '- Topic' from channel names"),
      secondary: const Icon(Icons.music_note_outlined),
      onChanged: (value) {
        setState(() {
          _hideTopics = value;
        });
        Persistence.hideTopics = value;
        Persistence.saveHideTopics();
      },
    );
  }
}
