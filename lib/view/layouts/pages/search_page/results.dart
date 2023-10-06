import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/enums/playlist_status.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';
import 'package:yt_playlists_plus/view/bottom_padding.dart';
import 'package:yt_playlists_plus/view/templates/playlist/playlist_view.dart';

class SearchResults extends StatelessWidget {
  final List<PlaylistController> results;
  const SearchResults({
    super.key,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          ...results.map(
            (playlist) {
              index++;
              return _Result(
                  playlist: playlist,
                  index: index,
                  resultsLength: results.length);
            },
          ),
          const AdaptiveHeightBox(
            androidHeight: 20,
            windowsHeight: 10,
          ),
        ],
      ),
    );
  }
}

class _Result extends StatelessWidget {
  final PlaylistController playlist;
  final int index;
  final int resultsLength;

  const _Result({
    required this.playlist,
    required this.index,
    required this.resultsLength,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: SizedBox(
            width: 700,
            child: ListenableProvider.value(
              value: playlist,
              child: PlaylistView(
                firstOfList: index == 1,
                lastOfList: index == resultsLength,
                onTap: () async {
                  if (playlist.status == PlaylistStatus.notDownloaded) {
                    try {
                      await playlist
                          .download()
                          .then((_) => PlaylistsController().save());
                    } on SocketException {
                      //?? do nothing
                    }
                  }
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
