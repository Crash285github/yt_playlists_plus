import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/settings_service/hide_topics_service.dart';

class HideTopicsSwitch extends StatefulWidget {
  const HideTopicsSwitch({super.key});

  @override
  State<HideTopicsSwitch> createState() => _HideTopicsSwitchState();
}

class _HideTopicsSwitchState extends State<HideTopicsSwitch> {
  bool _hideTopics = HideTopicsService().hideTopics;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: _hideTopics,
      title: const Text("Hide '- Topic' from channel names"),
      secondary: const Icon(Icons.note_outlined),
      onChanged: (value) {
        setState(() {
          _hideTopics = value;
        });

        HideTopicsService()
          ..set(value)
          ..save();
      },
    );
  }
}
