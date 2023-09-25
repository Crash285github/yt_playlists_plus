import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/services/playlists_service.dart';
import 'package:yt_playlists_plus/services/reorder_service.dart';
import 'package:yt_playlists_plus/view/template/playlist/playlist_view.dart';

class HomePagePlaylists extends StatefulWidget {
  final Function(Playlist) onTap;
  const HomePagePlaylists({super.key, required this.onTap});

  @override
  State<HomePagePlaylists> createState() => _HomePagePlaylistsState();
}

class _HomePagePlaylistsState extends State<HomePagePlaylists> {
  @override
  Widget build(BuildContext context) {
    List<Playlist> playlists = Provider.of<PlaylistsService>(context).playlists;
    bool canReorder = Provider.of<ReorderService>(context).canReorder;

    return SliverReorderableList(
      itemBuilder: (context, index) {
        return ReorderableDragStartListener(
          enabled: canReorder,
          index: index,
          key: ValueKey(playlists[index]),
          child: ListenableProvider.value(
            value: playlists[index],
            child: PlaylistView(
              firstOfList: index == 0 && !canReorder,
              lastOfList: index == playlists.length - 1 && !canReorder,
              onTap: () => widget.onTap(playlists[index]),
            ),
          ),
        );
      },
      itemCount: playlists.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final Playlist item = playlists.removeAt(oldIndex);
          playlists.insert(newIndex, item);
        });
        PlaylistsService().save();
      },
    );
  }
}
