import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import '../model/playlist/playlist_status.dart';

class PlaylistWidget extends StatelessWidget {
  ///The function that runs when you tap on the `PlaylistWidget`
  ///
  ///If not set, it navigates to the Playlist's Page
  final void Function()? onTap;

  const PlaylistWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Playlist playlist = Provider.of<Playlist>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black54,
        ),
        child: InkWell(
          onTap: () {
            if (onTap == null) {
              Navigator.pushNamed(context, '/playlist', arguments: playlist);
            } else {
              onTap!();
            }
          },
          borderRadius: BorderRadius.circular(10),
          child: Row(
            children: [
              Flexible(
                child: Row(
                  children: [
                    thumbnail(playlist.thumbnailUrl),
                    details(playlist),
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
  ///Title and Author of Playlist
  details(Playlist playlist) => Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              playlist.title,
              style: const TextStyle(fontSize: 30),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Text(
              playlist.author,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );

  ///The status Icon of the Playlist
  status(PlaylistStatus status) {
    Widget icon = Tooltip(
      waitDuration: const Duration(seconds: 1),
      message: status.name,
      child: Icon(
        status.icon,
        color: status.color,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(height: 50),
          icon,
        ],
      ),
    );
  }

  ///The thumbnail of the Playlist
  thumbnail(String thumbnailUrl) => Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: NetworkImage(
                thumbnailUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
