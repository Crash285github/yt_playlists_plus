import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/view/layouts/pages/home_page/refresh_button.dart';
import 'package:yt_playlists_plus/persistence.dart';
import 'package:yt_playlists_plus/services/playlists_service.dart';
import 'package:yt_playlists_plus/services/reorder_service.dart';
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
    Provider.of<PlaylistsService>(context).playlists;
    return StyledSliverAppBar(
      title: const Text("Playlists"),
      actions: ReorderService().canReorder
          ? []
          : [
              HomePageRefreshButton(
                fetchCount: _fetchCount,
                onPressed: _isFetchingAll
                    ? null
                    : () {
                        setState(() {
                          _isFetchingAll = true;
                          _fetchCount = PlaylistsService().playlists.length;
                        });

                        Persistence.disableExportImport();

                        Future.wait(
                          PlaylistsService().playlists.map(
                            (playlist) {
                              return playlist.status ==
                                          PlaylistStatus.fetching ||
                                      playlist.status ==
                                          PlaylistStatus.downloading
                                  ? Future(() => null)
                                  : playlist
                                      .fetchVideos()
                                      .then((_) async => await playlist.check())
                                      .then((_) => setState(() {
                                            _fetchCount--;
                                          }))
                                      .onError((error, stackTrace) {
                                      _fetchCount = 0;
                                    });
                            },
                          ).toList(),
                        ).then((_) {
                          setState(() {
                            _isFetchingAll = false;
                            _fetchCount = 0;
                          });
                          Persistence().tryEnableExportImport();
                        });
                      },
              )
            ],
    );
  }
}
