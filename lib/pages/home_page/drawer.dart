import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                "Settings",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const Divider(),
            const Expanded(child: DrawerSettings()),
            const Divider(height: 2),
            //About
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/about");
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "About",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Icon(Icons.info)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerSettings extends StatefulWidget {
  const DrawerSettings({super.key});

  @override
  State<DrawerSettings> createState() => _DrawerSettingsState();
}

class _DrawerSettingsState extends State<DrawerSettings> {
  bool _isDarkModeOn = ApplicationTheme.get() == ApplicationTheme.dark;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          value: _isDarkModeOn,
          title: Text(_isDarkModeOn ? "Dark Mode" : "Light Mode"),
          secondary: Icon(_isDarkModeOn
              ? Icons.dark_mode_outlined
              : Icons.light_mode_outlined),
          onChanged: (value) {
            _isDarkModeOn
                ? ApplicationTheme.set(ApplicationTheme.light)
                : ApplicationTheme.set(ApplicationTheme.dark);
            setState(() {
              _isDarkModeOn = value;
            });
            Persistence.save();
          },
        ),
      ],
    );
  }
}
