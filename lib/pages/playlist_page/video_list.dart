import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/widgets/video_widget.dart';
import '../../model/playlist/playlist.dart';
import '../../model/video/video.dart';

///Shows a list of videos as an ExpansionPanel
///
///The [title] parameter shows in the header
class VideoList extends StatefulWidget {
  final String title;
  final Set<Video> videos;

  const VideoList({
    super.key,
    required this.title,
    required this.videos,
  });

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  late bool _isExpanded;

  @override
  void initState() {
    _isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Playlist>(context);
    double expandedTileChildrenHeight =
        MediaQuery.of(context).size.height - kToolbarHeight - 200;
    if (expandedTileChildrenHeight < 0) expandedTileChildrenHeight = 0;
    return Card(
      margin: const EdgeInsets.all(10),
      child: ExpansionTile(
        title: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _isExpanded
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                width: 2,
              ),
            ),
          ),
          child: Text(
            "${widget.title} (${widget.videos.length})",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        onExpansionChanged: (value) => setState(() {
          _isExpanded = value;
        }),
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: expandedTileChildrenHeight),
            child: ListView(
              shrinkWrap: true,
              children: [
                ...widget.videos.map(
                  (e) => ListenableProvider.value(
                    value: e,
                    child: const VideoWidget(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
