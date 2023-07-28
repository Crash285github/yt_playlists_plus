import 'package:flutter/material.dart';

import '../../model/video.dart';

class VideoList extends StatelessWidget {
  final String title;
  final Set<Video> videos;
  const VideoList({super.key, required this.title, required this.videos});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            //videos,
          ),
          ...videos.map((e) => Text(e.title)).toList()
        ],
      ),
    );
  }
}
