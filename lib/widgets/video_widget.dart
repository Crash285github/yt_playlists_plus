import 'package:flutter/material.dart';
import '../model/video.dart';

class VideoWidget extends StatelessWidget {
  final Video video;

  ///The function that runs when you tap on the `VideoWidget`
  ///
  ///If null, the Widget does not ripple
  final void Function()? onTap;

  const VideoWidget({
    super.key,
    required this.video,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: onTap,
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
            Tooltip(
              message: video.title,
              waitDuration: const Duration(seconds: 1),
              child: Text(
                video.title,
                style: const TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              video.author,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );

  _thumbnail() => Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              image: NetworkImage(
                video.thumbnailUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
}
