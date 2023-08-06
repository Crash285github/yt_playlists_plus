import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/playlist_page/planned_list.dart';
import 'package:yt_playlists_plus/widgets/bottom_padding.dart';
import 'package:yt_playlists_plus/widgets/video_widget.dart';

class MoreTab extends StatefulWidget {
  final Playlist playlist;
  const MoreTab({super.key, required this.playlist});

  @override
  State<MoreTab> createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> with AutomaticKeepAliveClientMixin {
  final PanelController _controller = PanelController();

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    int index = 0;

    return SlidingUpPanel(
      color: Colors.transparent,
      minHeight: 95,
      parallaxEnabled: true,
      parallaxOffset: 0.2,
      backdropTapClosesPanel: true,
      backdropOpacity: 0.5,
      backdropColor: Colors.black,
      backdropEnabled: true,
      boxShadow: const [],
      controller: _controller,
      panelBuilder: (scrollController) {
        return PlannedList(
          planned: widget.playlist.planned,
          controller: _controller,
        );
      },
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Videos: (${widget.playlist.videos.length})",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const Divider(),
          const SizedBox(height: 16),
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
          const BottomPadding(androidHeight: 230, windowsHeight: 200),
        ],
      ),
    );
  }
}
