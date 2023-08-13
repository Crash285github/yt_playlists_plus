import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/widgets/playlist/widget.dart';

class SearchResults extends StatelessWidget {
  final List<Playlist> results;
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
              return ListenableProvider.value(
                value: playlist,
                child: PlaylistWidget(
                    firstOfList: index == 1,
                    lastOfList: index == results.length,
                    onTap: () async {
                      if (playlist.status == PlaylistStatus.notDownloaded) {
                        try {
                          await playlist.download();
                          await Persistence.save();
                        } on SocketException {
                          //? do nothing
                        }
                      }
                    }),
              );
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
