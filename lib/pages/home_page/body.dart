import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/widgets/bottom_padding.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/widgets/preset_sliver_app_bar.dart';
import 'package:yt_playlists_plus/widgets/playlist_widget.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  bool _isFetchingAll = false;
  int _fetchCount = 0;

  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);
    int index = 0;

    return CustomScrollView(
      slivers: [
        PresetSliverAppBar(
          title: const Text("Playlists"),
          actions: [
            RefreshButton(
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
                            return playlist.status == PlaylistStatus.fetching ||
                                    playlist.status ==
                                        PlaylistStatus.downloading
                                ? Future(() => null)
                                : playlist
                                    .fetchVideos()
                                    .drain()
                                    .then((_) => playlist.check())
                                    .then((_) => setState(() {
                                          _fetchCount--;
                                        }))
                                    .onError(
                                        (error, stackTrace) => _fetchCount = 0);
                          },
                        ).toList(),
                      ).then((_) => setState(() {
                            _isFetchingAll = false;
                            _fetchCount = 0;
                          }));
                    },
            )
          ],
        ),
        Persistence.playlists.isEmpty
            ? SliverFillRemaining(
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "No Playlists... let's find one!",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.grey),
                  ),
                )),
              )
            : SliverList(
                delegate: SliverChildListDelegate([
                  ...Persistence.playlists.map(
                    (e) {
                      index++;
                      return ListenableProvider.value(
                        value: e,
                        child: PlaylistWidget(
                          firstOfList: index == 1,
                          lastOfList: index == Persistence.playlists.length,
                        ),
                      );
                    },
                  ).toList(),
                  const BottomPadding()
                ]),
              ),
      ],
    );
  }
}

class RefreshButton extends StatelessWidget {
  final Function()? onPressed;
  final int fetchCount;

  const RefreshButton(
      {super.key, required this.onPressed, required this.fetchCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onPressed,
          tooltip: "Refresh all",
        ),
        fetchCount == 0
            ? const SizedBox.shrink()
            : Positioned(
                left: 15,
                bottom: 10,
                child: IgnorePointer(
                  ignoring: true,
                  child: Text("$fetchCount",
                      style: Theme.of(context).textTheme.titleSmall),
                ),
              ),
      ],
    );
  }
}
