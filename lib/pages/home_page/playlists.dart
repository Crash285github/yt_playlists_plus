import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/widgets/bottom_padding.dart';
import 'package:yt_playlists_plus/widgets/playlist/widget.dart';

class HomePagePlaylists extends StatelessWidget {
  const HomePagePlaylists({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);
    int index = 0;

    return SliverList(
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
    );
  }
}
