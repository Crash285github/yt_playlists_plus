import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../persistence/persistence.dart';
import '../../widgets/custom_sliver_app_bar.dart';
import '../../widgets/playlist_widget.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);

    return CustomScrollView(
      slivers: [
        customSliverAppBar(title: "HomePage", actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              for (var playlist in Persistence.playlists) {
                playlist
                    .fetchVideos()
                    .drain()
                    .then((value) => playlist.check());
              }
            },
            tooltip: "Refresh all",
          )
        ]),
        SliverList(
          delegate: SliverChildListDelegate(
            Persistence.playlists
                .map(
                  (e) => ListenableProvider.value(
                    value: e,
                    child: const PlaylistWidget(),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
