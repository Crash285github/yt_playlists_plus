import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/services/app_data_service.dart';
import 'package:yt_playlists_plus/controller/export_import_controller.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/services/popup_service/show_snackbar.dart';
import 'package:yt_playlists_plus/view/layouts/pages/about_page.dart';
import 'package:yt_playlists_plus/view/layouts/pages/home_page/drawer/settings_list.dart';
import 'package:yt_playlists_plus/view/layouts/responsive/split_view.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({super.key});

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ExportImportController>(context);
    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Title
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
                      onPressed: ExportImportController().enabled
                          ? () async {
                              await ExportImportController()
                                  .export()
                                  .then((success) {
                                if (success) {
                                  PopUpService().showSnackBar(
                                      context: context,
                                      message: "Data exported.");
                                }
                              });
                            }
                          : null,
                      icon: const Icon(Icons.arrow_downward),
                      label: const Text("Export")),
                  TextButton.icon(
                      onPressed: ExportImportController().enabled
                          ? () async {
                              Navigator.pop(context);
                              if (!await ExportImportController().import())
                                return;
                              await AppDataService.save().whenComplete(() {
                                SplitViewState.playlist = null;
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
