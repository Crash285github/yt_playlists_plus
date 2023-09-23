import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/popup_manager.dart';
import 'package:yt_playlists_plus/pages/about_page.dart';
import 'package:yt_playlists_plus/pages/home_page/drawer/settings_list.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/responsive/wide_layout.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({super.key});

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);

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
            const Expanded(child: Settings()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                      onPressed: Persistence.canExImport
                          ? () async {
                              await Persistence().export().then((success) {
                                if (success) {
                                  PopUpManager.showSnackBar(
                                      context: context,
                                      message: "Data exported.");
                                }
                              });
                            }
                          : null,
                      icon: const Icon(Icons.arrow_downward),
                      label: const Text("Export")),
                  TextButton.icon(
                      onPressed: Persistence.canExImport
                          ? () async {
                              Navigator.pop(context);
                              if (!await Persistence().import()) return;
                              await Persistence().saveAll().then((_) {
                                WideLayoutState.playlist = null;
                              });
                            }
                          : null,
                      icon: const Icon(Icons.arrow_upward),
                      label: const Text("Import")),
                ],
              ),
            ),
            const Divider(),
            //About
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ));
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
