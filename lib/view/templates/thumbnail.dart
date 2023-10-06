import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/config.dart';
import 'package:yt_playlists_plus/view/abstract_list_widget.dart';

///A Rectangular Widget for showing YouTube thumbnails
class ThumbnailImage extends ListWidget {
  ///The address of the thumbnail
  final String url;

  ///Width and height of the Widget
  final double size;

  //?? Radius of large corners, adjusted to its container
  final double _largeCorner = AppConfig.largeCornerRadius - 2;

  //?? Radius of small corners
  final double _smallCorner = AppConfig.smallCornerRadius;

  const ThumbnailImage({
    super.key,
    super.firstOfList,
    super.lastOfList,
    required this.url,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: AnimatedContainer(
        duration: AppConfig.animationDuration,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius:
              radiusBuilder(largeCorner: _largeCorner, smallCorner: _smallCorner)
                  .copyWith(
                      topRight: Radius.circular(_smallCorner),
                      bottomRight: Radius.circular(_smallCorner)),
        ),
        child: SizedBox(
            height: size,
            width: size,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              useOldImageOnUrlChange: true,
              fadeInDuration: AppConfig.animationDuration,
              fadeOutDuration: AppConfig.animationDuration,
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
      ),
    );
  }
}
