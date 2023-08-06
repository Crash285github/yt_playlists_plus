import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/model/video/video.dart';
import 'package:yt_playlists_plus/model/video/video_status.dart';
import 'package:yt_playlists_plus/widgets/video_widget.dart';

class ChangesTab extends StatelessWidget {
  final Set<Video> added;
  final Set<Video> missing;

  const ChangesTab({super.key, required this.added, required this.missing});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    Set<Video> changes = (added.toList() + missing.toList()).toSet();

    Playlist playlist = Provider.of<Playlist>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Status: ${playlist.status.displayName}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: playlist.status.color),
                ),
              ),
              TextButton(
                  onPressed: changes.isEmpty ||
                          playlist.status != PlaylistStatus.changed
                      ? null
                      : () {
                          for (var video in changes) {
                            if (video.status != VideoStatus.pending) {
                              video.function!();
                            }
                          }
                        },
                  child: const Row(
                    children: [Text("Pend all"), Icon(Icons.clear_all)],
                  ))
            ],
          ),
        ),
        playlist.status == PlaylistStatus.changed
            ? Expanded(
                child: ListView(
                children: [
                  ...changes.map(
                    (e) {
                      index++;
                      return ListenableProvider.value(
                        value: e,
                        child: VideoWidget(
                          firstOfList: index == 1,
                          lastOfList: index == changes.length,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ))
            : const SizedBox.shrink()
      ],
    );
  }
}
