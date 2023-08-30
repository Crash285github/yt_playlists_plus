import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/widgets/playlist/widget.dart';

class HomePagePlaylists extends StatefulWidget {
  const HomePagePlaylists({super.key});

  @override
  State<HomePagePlaylists> createState() => _HomePagePlaylistsState();
}

class _HomePagePlaylistsState extends State<HomePagePlaylists> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Persistence>(context);

    return SliverReorderableList(
      itemBuilder: (context, index) {
        return ReorderableDragStartListener(
          enabled: Persistence.canReorder,
          index: index,
          key: ValueKey(Persistence.playlists[index]),
          child: ListenableProvider.value(
            value: Persistence.playlists[index],
            child: PlaylistWidget(
              firstOfList: index == 0,
              lastOfList: index == Persistence.playlists.length - 1,
            ),
          ),
        );
      },
      itemCount: Persistence.playlists.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final Playlist item = Persistence.playlists.removeAt(oldIndex);
          Persistence.playlists.insert(newIndex, item);
        });
        Persistence.savePlaylists();
      },
    );
  }
}
