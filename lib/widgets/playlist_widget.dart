import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/Playlist/playlist.dart';
import '../model/Playlist/playlist_state.dart';

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
              state(playlist.state),
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

  ///The state Icon of the Playlist
  state(PlaylistState state) {
    Widget icon;

    iconBuilder(String message, IconData icon, Color color) => Tooltip(
          waitDuration: const Duration(seconds: 1),
          message: message,
          child: Icon(
            icon,
            color: color,
          ),
        );

    icon = switch (state) {
      PlaylistState.downloading => iconBuilder(
          "Downloading",
          Icons.file_download,
          Colors.green,
        ),
      PlaylistState.downloaded => iconBuilder(
          "Downloaded",
          Icons.file_download_done_outlined,
          Colors.green,
        ),
      PlaylistState.unChecked => iconBuilder(
          "Unchecked",
          Icons.refresh,
          Colors.grey,
        ),
      PlaylistState.fetching => iconBuilder(
          "Fetching",
          Icons.update,
          Colors.teal,
        ),
      PlaylistState.checking => iconBuilder(
          "Checking",
          Icons.refresh,
          Colors.grey,
        ),
      PlaylistState.unChanged => iconBuilder(
          "Unchanged",
          Icons.check,
          Colors.green,
        ),
      PlaylistState.changed => iconBuilder(
          "Changed",
          Icons.error,
          Colors.amber,
        ),
      PlaylistState.notFound => iconBuilder(
          "Not Found",
          Icons.close,
          Colors.red,
        ),
    };

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
