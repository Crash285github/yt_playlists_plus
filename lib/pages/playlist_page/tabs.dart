import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/widgets/history_widget.dart';
import 'package:yt_playlists_plus/widgets/video_widget.dart';
import '../../model/playlist/playlist.dart';
import '../../model/video/video.dart';
import '../../model/video/video_history.dart';

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
                            video.function!();
                          }
                        },
                  child: const Row(
                    children: [Text("Confirm all"), Icon(Icons.clear_all)],
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

class MoreTab extends StatefulWidget {
  final Playlist playlist;
  const MoreTab({super.key, required this.playlist});

  @override
  State<MoreTab> createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    int index = 0;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Text(
                "Videos:",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        ...widget.playlist.videos.map((e) {
          index++;
          return ListenableProvider.value(
              value: e,
              child: VideoWidget(
                firstOfList: index == 1,
                lastOfList: index == widget.playlist.videos.length,
                isInteractable: false,
              ));
        }),
        const SizedBox(height: 80),
      ],
    );
  }
}

class HistoryTab extends StatefulWidget {
  final List<VideoHistory> history;
  const HistoryTab({super.key, required this.history});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    int index = 0;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "History",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                onPressed: widget.history.isEmpty
                    ? null
                    : () => setState(() => widget.history.clear()),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Clear"), Icon(Icons.clear)],
                ),
              )
            ],
          ),
        ),
        ...widget.history.reversed.map(
          (videoHistory) {
            index++;
            return HistoryWidget(
              videoHistory: videoHistory,
              firstOfList: index == 1,
              lastOfList: index == widget.history.length,
            );
          },
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
