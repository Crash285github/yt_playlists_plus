import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/pages/home_page/refresh_button.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/widgets/preset_sliver_app_bar.dart';

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
    Provider.of<Persistence>(context);
    return PresetSliverAppBar(
      title: const Text("Playlists"),
      actions: Persistence.canReorder
          ? []
          : [
              HomePageRefreshButton(
                fetchCount: _fetchCount,
                onPressed: _isFetchingAll
                    ? null
                    : () {
                        setState(() {
                          _isFetchingAll = true;
                          _fetchCount = Persistence.playlists.length;
                        });

                        Future.wait(
                          Persistence.playlists.map(
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
                        });
                      },
              )
            ],
    );
  }
}
