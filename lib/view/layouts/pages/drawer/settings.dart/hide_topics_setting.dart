import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/hide_topics_controller.dart';

class HideTopicsSetting extends StatefulWidget {
  const HideTopicsSetting({super.key});

  @override
  State<HideTopicsSetting> createState() => _HideTopicsSettingState();
}

class _HideTopicsSettingState extends State<HideTopicsSetting> {
  bool _hideTopics = HideTopicsController().hideTopics;

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

        HideTopicsController()
          ..set(value)
          ..save();
      },
    );
  }
}
