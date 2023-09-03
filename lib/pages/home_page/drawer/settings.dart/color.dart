import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/persistence/color_scheme.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class ColorSetting extends StatefulWidget {
  const ColorSetting({super.key});

  @override
  State<ColorSetting> createState() => _ColorSettingState();
}

class _ColorSettingState extends State<ColorSetting> {
  ApplicationColor _color = ApplicationColorScheme.get();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.color_lens_outlined),
      title: const Text("App color"),
      trailing: DropdownButton<ApplicationColor>(
        value: _color,
        alignment: Alignment.center,
        underline: const SizedBox.shrink(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        borderRadius: BorderRadius.circular(10.0),
        iconSize: 0,
        items: [
          ...ApplicationColor.values.map((ApplicationColor color) {
            return DropdownMenuItem<ApplicationColor>(
              value: color,
              child: Text(
                color.displayName,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: color.color),
              ),
            );
          })
        ],
        onChanged: (value) {
          setState(() {
            _color = value!;
          });
          ApplicationColorScheme.set(value ?? ApplicationColor.dynamic);
          Persistence.saveColor();
        },
      ),
    );
  }
}
