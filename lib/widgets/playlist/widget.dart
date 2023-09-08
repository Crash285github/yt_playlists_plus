import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/constants.dart';
import 'package:yt_playlists_plus/widgets/icard.dart';
import 'package:yt_playlists_plus/widgets/playlist/details.dart';
import 'package:yt_playlists_plus/widgets/playlist/progress.dart';
import 'package:yt_playlists_plus/widgets/playlist/status.dart';
import 'package:yt_playlists_plus/widgets/thumbnail.dart';

class PlaylistWidget extends ICardWidget {
  ///The function that runs when you tap on the `PlaylistWidget`
  final void Function()? onTap;

  const PlaylistWidget({
    super.key,
    super.firstOfList = false,
    super.lastOfList = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Playlist playlist = Provider.of<Playlist>(context);

    return Card(
      shape: cardBorder(firstOfList: firstOfList, lastOfList: lastOfList),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (playlist.status == PlaylistStatus.fetching)
            PlaylistProgressIndicator(progress: playlist.progress / 100),
          Ink(
            child: InkWell(
              onTap: Persistence.canReorder ? null : onTap,
              child: Row(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        playlist.thumbnailUrl != ""
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(3, 3, 10, 3),
                                child: ThumbnailImage(
                                  thumbnailUrl: playlist.thumbnailUrl,
                                  largeRadius: 13.0,
                                  smallRadius: 4.0,
                                  size: 85.0,
                                  firstOfList: firstOfList,
                                  lastOfList: lastOfList,
                                ),
                              )
                            : const SizedBox(width: 10),
                        PlaylistDetails(playlist: playlist),
                      ],
                    ),
                  ),
                  PlaylistStatusWidget(status: playlist.status),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
