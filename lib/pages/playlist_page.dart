import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/widgets/widgets_export.dart';

class PlaylistPage extends StatefulWidget {

  const PlaylistPage({
    super.key
  });

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            customSliverAppBar("playlistTitle"),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _videoList("New videos:"),
                  _videoList("Missing videos:"),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _bottomAppBar());
  }

  //#region BottomAppBar
  BottomAppBar _bottomAppBar() => BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //save
            TextButton(
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(Icons.save),
                    SizedBox(width: 10),
                    Text("Save"),
                  ],
                ),
              ),
              onPressed: () {},
            ),
            //planned
            TextButton(
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(Icons.watch_later),
                    SizedBox(width: 10),
                    Text("Planned"),
                  ],
                ),
              ),
              onPressed: () {},
            ),
            //delete
            TextButton(
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(Icons.delete),
                    SizedBox(width: 10),
                    Text("Delete"),
                  ],
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      );
  //#endregion

  //#region VideoList
  _videoList(String title) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black54,
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //title
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              //videos
            ),
          ],
        ),
      );
  //#endregion
}
