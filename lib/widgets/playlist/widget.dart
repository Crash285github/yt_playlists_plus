import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/persistence/theme_constants.dart';
import 'package:yt_playlists_plus/widgets/icard.dart';
import 'package:yt_playlists_plus/widgets/playlist/details.dart';
import 'package:yt_playlists_plus/widgets/playlist/status.dart';
import 'package:yt_playlists_plus/widgets/thumbnail.dart';

class PlaylistWidget extends ICardWidget {
  ///The function that runs when you tap on the `PlaylistWidget`
  ///
  ///If not set, it navigates to the Playlist's Page
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
      child: Ink(
        child: InkWell(
          onTap: () async {
            if (onTap == null) {
              Navigator.pushNamed(context, '/playlist', arguments: playlist);
              Persistence.disableReorder();
            } else {
              onTap!();
            }
          },
          child: Row(
            children: [
              Flexible(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(3, 3, 10, 3),
                      child: ThumbnailImage(
                        thumbnailUrl: playlist.thumbnailUrl,
                        largeRadius: 13.0,
                        smallRadius: 4.0,
                        size: 85.0,
                        firstOfList: firstOfList,
                        lastOfList: lastOfList,
                      ),
                    ),
                    PlaylistDetails(playlist: playlist),
                  ],
                ),
              ),
              PlaylistStatusWidget(status: playlist.status),
            ],
          ),
        ),
      ),
    );
  }
}
