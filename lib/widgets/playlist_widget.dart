import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';
import 'package:yt_playlists_plus/persistence/theme_constants.dart';
import 'package:yt_playlists_plus/widgets/icard.dart';
import '../model/playlist/playlist_status.dart';

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
          onTap: () {
            if (onTap == null) {
              Navigator.pushNamed(context, '/playlist', arguments: playlist);
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
                      child: thumbnail(
                          thumbnailUrl: playlist.thumbnailUrl,
                          firstOfList: firstOfList,
                          lastOfList: lastOfList),
                    ),
                    details(context, playlist),
                  ],
                ),
              ),
              status(playlist.status),
            ],
          ),
        ),
      ),
    );
  }
}

extension _PlaylistWidgetExtension on PlaylistWidget {
  details(BuildContext context, Playlist playlist) => Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Text(
              playlist.title,
              style: Theme.of(context).textTheme.titleLarge,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            //author
            Text(
              playlist.author,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: ApplicationTheme.get() == ApplicationTheme.light
                        ? Colors.grey[700]
                        : Colors.grey,
                  ),
            ),
          ],
        ),
      );

  ///The status Icon of the Playlist
  status(PlaylistStatus status) {
    Widget icon = Tooltip(
      message: status.displayName,
      child: Icon(
        status.icon,
        color: status.color,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(height: 40),
          icon,
        ],
      ),
    );
  }

  ///The thumbnail of the Playlist
  thumbnail(
          {required String thumbnailUrl,
          bool firstOfList = false,
          bool lastOfList = false}) =>
      ClipRRect(
        borderRadius: firstOfList && lastOfList
            ? const BorderRadius.only(
                topLeft: Radius.circular(13),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(13),
                bottomRight: Radius.circular(4),
              )
            : firstOfList
                ? const BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  )
                : lastOfList
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                        bottomLeft: Radius.circular(13),
                        bottomRight: Radius.circular(4),
                      )
                    : const BorderRadius.all(Radius.circular(4)),
        child: SizedBox(
          height: 85,
          width: 85,
          child: Image.network(
            thumbnailUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/no-thumbnail.png",
                    fit: BoxFit.cover,
                  ),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Tooltip(
                      message: "Thumbnail not found",
                      child: Icon(
                        Icons.warning,
                        color: Colors.amber,
                      ),
                    ),
                  )
                ]),
          ),
        ),
      );
}
