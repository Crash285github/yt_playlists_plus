import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/services/playlists_service.dart';
import 'package:yt_playlists_plus/services/reorder_service.dart';
import 'package:yt_playlists_plus/view/widgets/playlist/widget.dart';

class HomePagePlaylists extends StatefulWidget {
  final Function(Playlist) onTap;
  const HomePagePlaylists({super.key, required this.onTap});

  @override
  State<HomePagePlaylists> createState() => _HomePagePlaylistsState();
}

class _HomePagePlaylistsState extends State<HomePagePlaylists> {
  @override
  Widget build(BuildContext context) {
    Provider.of<PlaylistsService>(context).playlists;
    Provider.of<ReorderService>(context).canReorder;

    return SliverReorderableList(
      itemBuilder: (context, index) {
        return ReorderableDragStartListener(
          enabled: ReorderService().canReorder,
          index: index,
          key: ValueKey(PlaylistsService().playlists[index]),
          child: ListenableProvider.value(
            value: PlaylistsService().playlists[index],
            child: PlaylistWidget(
              firstOfList: index == 0 && !ReorderService().canReorder,
              lastOfList: index == PlaylistsService().playlists.length - 1 &&
                  !ReorderService().canReorder,
              onTap: () => widget.onTap(PlaylistsService().playlists[index]),
            ),
          ),
        );
      },
      itemCount: PlaylistsService().playlists.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final Playlist item = PlaylistsService().playlists.removeAt(oldIndex);
          PlaylistsService().playlists.insert(newIndex, item);
        });
        PlaylistsService().save();
      },
    );
  }
}
