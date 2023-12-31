import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/videos/planned/top_bar.dart';

class EmptyPlanned extends StatelessWidget {
  final ScrollController scrollController;
  final Function()? onAddPressed;
  final Function()? onHandleTapped;

  const EmptyPlanned({
    super.key,
    required this.onAddPressed,
    required this.scrollController,
    required this.onHandleTapped,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      children: [
        ...TopBar.build(
          plannedSize: 0,
          onAddPressed: onAddPressed,
          onHandleTapped: onHandleTapped,
        ),
        SizedBox(
          height: 300,
          child: Center(
              child: Text(
            "Nothing in planned...",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
          )),
        )
      ],
    );
  }
}
