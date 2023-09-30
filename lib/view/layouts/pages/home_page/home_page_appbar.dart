import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/enums/playlist_status.dart';
import 'package:yt_playlists_plus/controller/export_import_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/home_page/home_page_refresh_all_button.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';
import 'package:yt_playlists_plus/controller/reorder_controller.dart';
import 'package:yt_playlists_plus/view/templates/styled_sliver_app_bar.dart';

class HomePageAppBar extends StatefulWidget {
  const HomePageAppBar({super.key});

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  bool _isFetchingAll = false;
  int _fetchCount = 0;

  @override
  Widget build(BuildContext context) {
    List<PlaylistController> playlists =
        Provider.of<PlaylistsService>(context).playlists;
    bool canReorder = Provider.of<ReorderService>(context).canReorder;

    return StyledSliverAppBar(
      title: const Text("Playlists"),
      actions: canReorder
          ? null
          : [
              HomePageRefreshAllButton(
                fetchCount: _fetchCount,
                onPressed: _isFetchingAll || playlists.isEmpty
                    ? null
                    : () {
                        setState(() {
                          _isFetchingAll = true;
                          _fetchCount = playlists.length;
                        });

                        ExportImportController().disable();

                        Future.wait(
                          playlists.map(
                            (playlist) {
                              return playlist.status ==
                                          PlaylistStatus.fetching ||
                                      playlist.status ==
                                          PlaylistStatus.downloading
                                  ? Future(() => null)
                                  : playlist
                                      .fetchVideos()
                                      .whenComplete(
                                          () async => await playlist.check())
                                      .whenComplete(() => setState(() {
                                            _fetchCount--;
                                          }))
                                      .onError((error, stackTrace) {
                                      _fetchCount = 0;
                                    });
                            },
                          ).toList(),
                        ).whenComplete(() {
                          setState(() {
                            _isFetchingAll = false;
                            _fetchCount = 0;
                          });
                          ExportImportController().tryEnable();
                        });
                      },
              )
            ],
    );
  }
}
