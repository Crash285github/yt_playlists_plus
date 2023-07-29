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

    switch (state) {
      case PlaylistState.downloading:
        icon = const Tooltip(
          waitDuration: Duration(seconds: 1),
          message: "Downloading",
          child: Icon(
            Icons.file_download,
            color: Colors.green,
          ),
        );
        break;
      case PlaylistState.downloaded:
        icon = const Tooltip(
          waitDuration: Duration(seconds: 1),
          message: "Downloaded",
          child: Icon(
            Icons.file_download_done,
            color: Colors.green,
          ),
        );
        break;
      case PlaylistState.unChecked:
        icon = const Tooltip(
          waitDuration: Duration(seconds: 1),
          message: "Unchecked",
          child: Icon(
            Icons.refresh,
            color: Colors.grey,
          ),
        );
        break;
      case PlaylistState.fetching:
        icon = const Tooltip(
          waitDuration: Duration(seconds: 1),
          message: "Fetching",
          child: Icon(
            Icons.data_array,
            color: Colors.teal,
          ),
        );
        break;
      case PlaylistState.checking:
        icon = const Tooltip(
          waitDuration: Duration(seconds: 1),
          message: "Checking",
          child: Icon(
            Icons.analytics,
            color: Colors.blue,
          ),
        );
        break;
      case PlaylistState.unChanged:
        icon = const Tooltip(
          waitDuration: Duration(seconds: 1),
          message: "Unchanged",
          child: Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
        break;
      case PlaylistState.changed:
        icon = const Tooltip(
          waitDuration: Duration(seconds: 1),
          message: "Changed",
          child: Icon(
            Icons.error,
            color: Colors.amber,
          ),
        );
        break;
      case PlaylistState.notFound:
        icon = const Tooltip(
          waitDuration: Duration(seconds: 1),
          message: "Not Found",
          child: Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
        break;
    }

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
