import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/config.dart';
import 'package:yt_playlists_plus/services/app_data_service.dart';
import 'package:yt_playlists_plus/controller/export_import_controller.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/services/popup_service/show_snackbar.dart';
import 'package:yt_playlists_plus/view/layouts/pages/about_page.dart';
import 'package:yt_playlists_plus/view/layouts/pages/drawer/settings_list.dart';
import 'package:yt_playlists_plus/view/layouts/responsive/split_view.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    Provider.of<ExportImportController>(context);
    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //__Title
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConfig.spacing, vertical: 5),
              child: Text(
                "Settings",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const Divider(),
            const Expanded(child: Settings()),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
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
                              if (!await ExportImportController().import()) {
                                return;
                              }
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
            //__About
            InkWell(
              onTap: () {
                final NavigatorState nav =
                    Navigator.of(AppConfig.rightKey.currentContext ?? context);
                if (nav.canPop()) nav.pop();
                nav.push(
                    MaterialPageRoute(builder: (context) => const AboutPage()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConfig.spacing, vertical: 10),
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
