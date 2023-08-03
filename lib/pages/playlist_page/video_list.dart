import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/widgets/video_widget.dart';
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
  late final List<bool> _isExpanded;

  @override
  void initState() {
    _isExpanded = [false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videos.isEmpty) return const Text("");
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 0),
        children: [
          ExpansionPanel(
            canTapOnHeader: true,
            backgroundColor: Colors.transparent,
            headerBuilder: (context, isExpanded) {
              return Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              );
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...widget.videos.map(
                  (e) => ListenableProvider.value(
                    value: e,
                    child: const VideoWidget(),
                  ),
                )
              ],
            ),
            isExpanded: _isExpanded[0],
          ),
        ],
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            _isExpanded[panelIndex] = !isExpanded;
          });
        },
      ),
    );
  }
}
