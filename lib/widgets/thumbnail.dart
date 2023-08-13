import 'package:flutter/material.dart';

class ThumbnailImage extends StatelessWidget {
  final String thumbnailUrl;

  final bool firstOfList;
  final bool lastOfList;

  ///Radius of large corner (of first or last of list)
  final double largeRadius;

  ///Radius of small corner
  final double smallRadius;

  ///Width and height
  final double size;

  const ThumbnailImage({
    super.key,
    required this.thumbnailUrl,
    required this.largeRadius,
    required this.smallRadius,
    required this.size,
    this.firstOfList = false,
    this.lastOfList = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: firstOfList && lastOfList
          ? BorderRadius.only(
              topLeft: Radius.circular(largeRadius),
              topRight: Radius.circular(smallRadius),
              bottomLeft: Radius.circular(largeRadius),
              bottomRight: Radius.circular(smallRadius),
            )
          : firstOfList
              ? BorderRadius.only(
                  topLeft: Radius.circular(largeRadius),
                  topRight: Radius.circular(smallRadius),
                  bottomLeft: Radius.circular(smallRadius),
                  bottomRight: Radius.circular(smallRadius),
                )
              : lastOfList
                  ? BorderRadius.only(
                      topLeft: Radius.circular(smallRadius),
                      topRight: Radius.circular(smallRadius),
                      bottomLeft: Radius.circular(largeRadius),
                      bottomRight: Radius.circular(smallRadius),
                    )
                  : BorderRadius.all(Radius.circular(smallRadius)),
      child: SizedBox(
        height: size,
        width: size,
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
}
