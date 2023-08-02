import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import '../../persistence/persistence.dart';
import '../../widgets/custom_sliver_app_bar.dart';
import '../../widgets/playlist_widget.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  bool _isFetchingAll = false;
  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);

    return CustomScrollView(
      slivers: [
        customSliverAppBar(
          title: "HomePage",
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _isFetchingAll
                  ? null
                  : () {
                      setState(() {
                        _isFetchingAll = true;
                      });

                      Future.wait(
                        Persistence.playlists.map(
                          (playlist) {
                            return playlist.status == PlaylistStatus.fetching
                                ? Future(() => null)
                                : playlist
                                    .fetchVideos()
                                    .drain()
                                    .then((_) => playlist.check());
                          },
                        ).toList(),
                      ).then((_) => setState(() {
                            _isFetchingAll = false;
                          }));
                    },
              tooltip: "Refresh all",
            )
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            ...Persistence.playlists
                .map(
                  (e) => ListenableProvider.value(
                    value: e,
                    child: const PlaylistWidget(),
                  ),
                )
                .toList(),
            const SizedBox(height: 100)
          ]),
        ),
      ],
    );
  }
}
