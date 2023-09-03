import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/persistence/split_portions.dart';

class SplitViewSetting extends StatefulWidget {
  const SplitViewSetting({super.key});

  @override
  State<SplitViewSetting> createState() => _SplitViewSettingState();
}

class _SplitViewSettingState extends State<SplitViewSetting> {
  final double _pi = 3.1415926535897932;
  SplitPortions _portions = ApplicationSplitPortions.get();

  @override
  Widget build(BuildContext context) {
    Provider.of<ApplicationSplitPortions>(context);

    return ListTile(
      leading: Transform.rotate(
          angle: (_pi / 2), child: const Icon(Icons.splitscreen_outlined)),
      title: const Text("Split view"),
      trailing: DropdownButton(
        value: _portions,
        iconSize: 0,
        items: const [
          DropdownMenuItem(
            value: SplitPortions.even,
            child: Text("Even"),
          ),
          DropdownMenuItem(
            value: SplitPortions.uneven,
            child: Text("Uneven"),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _portions = value!;
          });
          ApplicationSplitPortions.set(value!);
          Persistence.saveSplitPortions();
        },
      ),
    );
  }
}
