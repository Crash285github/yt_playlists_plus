import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/pages/playlist_page/planned_list.dart';
import 'package:yt_playlists_plus/pages/playlist_page/video_list.dart';
import 'package:yt_playlists_plus/widgets/history_widget.dart';
import '../../model/playlist/playlist.dart';
import '../../model/video/video.dart';
import '../../model/video/video_history.dart';

class ChangesTab extends StatelessWidget {
  final Set<Video> added;
  final Set<Video> missing;

  const ChangesTab({super.key, required this.added, required this.missing});

  @override
  @override
  Widget build(BuildContext context) {
    Playlist playlist = Provider.of<Playlist>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Status: ${playlist.status.displayName}',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: playlist.status.color),
          ),
        ),
        playlist.status == PlaylistStatus.changed
            ? Expanded(
                child: ListView(
                children: [
                  VideoList(
                    title: "Added",
                    videos: added,
                    isInteractable: true,
                  ),
                  VideoList(
                    title: "Missing",
                    videos: missing,
                    isInteractable: true,
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
    return ListView(
      children: [
        PlannedList(planned: widget.playlist.planned),
        VideoList(
          title: "Videos",
          videos: widget.playlist.videos,
          isInteractable: false,
        ),
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
                onPressed: () => setState(() => widget.history.clear()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Clear",
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.red,
                          ),
                    ),
                    Icon(Icons.clear),
                  ],
                ),
              )
            ],
          ),
        ),
        ...widget.history.reversed.map(
          (videoHistory) => HistoryWidget(
            videoHistory: videoHistory,
            firstOfList:
                widget.history.last == videoHistory, //?list is reversed
            lastOfList: widget.history.first == videoHistory, //? -||-
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
