import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/Playlist/playlist.dart';

class PlaylistWidget extends StatelessWidget {
  final Playlist playlist;

  ///The function that runs when you tap on the `PlaylistWidget`
  ///
  ///If not set, it navigates to the Playlist's Page
  final void Function()? onTap;

  const PlaylistWidget({
    super.key,
    required this.playlist,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                    _thumbnail(),
                    _details(),
                  ],
                ),
              ),
              _status(),
            ],
          ),
        ),
      ),
    );
  }

  _details() => Flexible(
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

  _status() => const Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          ],
        ),
      );

  _thumbnail() => Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: NetworkImage(
                playlist.thumbnailUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
