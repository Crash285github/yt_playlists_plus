import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/persistence/color_scheme.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class ColorSetting extends StatefulWidget {
  const ColorSetting({super.key});

  @override
  State<ColorSetting> createState() => _ColorSettingState();
}

class _ColorSettingState extends State<ColorSetting> {
  ApplicationColor _color = Persistence.color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.color_lens_outlined),
      title: const Text("App color"),
      subtitle: Text(
        "Change applies after restart.",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
      ),
      trailing: DropdownButton<ApplicationColor>(
        value: _color,
        iconSize: 0,
        items: [
          ...ApplicationColor.values.map((ApplicationColor color) {
            return DropdownMenuItem<ApplicationColor>(
                value: color, child: Text(color.displayName));
          })
        ],
        onChanged: (value) {
          setState(() {
            _color = value!;
          });
          Persistence.color = value ?? ApplicationColor.dynamic;
          Persistence.saveColor();
        },
      ),
    );
  }
}
