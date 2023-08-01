import 'package:flutter/material.dart';

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
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const Expanded(
              child: DrawerSettings(),
            ),
            //About
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("/about");
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "About",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(Icons.info)
                    ],
                  ),
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
  bool _isDarkModeOn = true;

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
            setState(() {
              _isDarkModeOn = value;
            });
          },
        ),
      ],
    );
  }
}
