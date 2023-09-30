import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/changes/tab_changes.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/history/tab_history.dart';
import 'package:yt_playlists_plus/view/layouts/pages/playlist_page/tabs/videos/videos_tab.dart';

class PlaylistPageBody extends StatelessWidget {
  final PlaylistController playlist;

  const PlaylistPageBody({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: SizedBox(
            width: double.infinity,
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Opacity(
                opacity: 0.7,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: playlist.thumbnailUrl,
                    fit: BoxFit.cover,
                    useOldImageOnUrlChange: true,
                    fadeInDuration: const Duration(milliseconds: 200),
                    fadeOutDuration: const Duration(milliseconds: 200),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/no-thumbnail.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: SafeArea(
          child: TabBarView(
            children: [
              ChangesTab(
                added: playlist.getAdded(),
                missing: playlist.getMissing(),
              ),
              VideosTab(playlist: playlist),
              HistoryTab(history: playlist.history),
            ],
          ),
        ),
      ),
    ]);
  }
}
