import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/extensions/is_youtube_link.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/enums/playlist_status.dart';
import 'package:yt_playlists_plus/controller/playlists_controller.dart';
import 'package:yt_playlists_plus/services/fetching_service.dart';

///Provides the searching logic for `SearchPage`
class SearchingController extends ChangeNotifier {
  bool isSearching = false;
  bool _isCanceled = false;
  final List<PlaylistController> searchResults = [];
  double progress = 0;

  void cancel() => _isCanceled = true;

  Future<SearchState> search({required String query}) async {
    isSearching = true;
    progress = 0;
    notifyListeners();

    searchResults.clear();
    query = query.trim();
    SearchState state = SearchState.noResults;

    if (query.isYoutubePlaylistLink()) {
      try {
        PlaylistController? playlist =
            await FetchingService.searchByLink(url: query);
        if (playlist != null) {
          playlist.status = PlaylistStatus.notDownloaded;
          searchResults.add(playlist);
          notifyListeners();
        }
      } on SocketException {
        state = SearchState.networkError;
      }
      state = SearchState.noResults;
    } else {
      try {
        await for (PlaylistController playlist in FetchingService.searchByQuery(
            query: query,
            excludedWords:
                PlaylistsService().playlists.map((pl) => pl.id).toList())) {
          if (_isCanceled) return SearchState.canceled;
          if (PlaylistsService().playlists.contains(playlist)) continue;

          playlist.status = PlaylistStatus.notDownloaded;
          searchResults.add(playlist);
          progress++;
          notifyListeners();
        }
      } on SocketException {
        state = SearchState.networkError;
      }
    }

    isSearching = false;
    notifyListeners();
    if (progress == 0) return SearchState.noResults;
    return state;
  }

  @override
  void dispose() {
    cancel();
    super.dispose();
  }
}

enum SearchState {
  success,
  networkError(message: "Network error."),
  noResults(message: "No results found."),
  canceled,
  ;

  const SearchState({this.message});

  final String? message;
}
