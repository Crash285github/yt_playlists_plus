import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/view/abstract_list_widget.dart';

///A Rectangular Widget for showing YouTube thumbnails
class ThumbnailImage extends ListWidget {
  ///The address of the thumbnail
  final String url;

  ///Radius of large corners
  ///
  ///Active if Widget is [firstOfList] or [lastOfList]
  final double strongCorner;

  ///Radius of small corners
  ///
  ///Active if Widget is not ([firstOfList] and [lastOfList])
  final double weakCorner;

  ///Width and height of the Widget
  final double size;

  const ThumbnailImage({
    super.key,
    super.firstOfList,
    super.lastOfList,
    required this.url,
    required this.strongCorner,
    required this.weakCorner,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: radiusBuilder().copyWith(
            topRight: Radius.circular(weakCorner),
            bottomRight: Radius.circular(weakCorner)),
      ),
      child: SizedBox(
          height: size,
          width: size,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            useOldImageOnUrlChange: true,
            fadeInDuration: const Duration(milliseconds: 200),
            fadeOutDuration: const Duration(milliseconds: 200),
            errorWidget: (context, url, error) => Stack(
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
                      message: "Thumbnail could not be loaded",
                      child: Icon(
                        Icons.warning,
                        color: Colors.amber,
                      ),
                    ),
                  )
                ]),
          )),
    );
  }
}
