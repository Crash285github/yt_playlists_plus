import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/extensions/is_youtube_link.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/services/playlists_service.dart';
import 'package:yt_playlists_plus/services/fetching_service.dart';

///Provides the searching logic for `SearchPage`
class SearchService extends ChangeNotifier {
  bool isSearching = false;
  bool _isCanceled = false;
  final List<Playlist> searchResults = [];
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
        Playlist? playlist = await FetchingService.searchByLink(url: query);
        if (playlist != null) {
          playlist.setStatus(PlaylistStatus.notDownloaded);
          searchResults.add(playlist);
          notifyListeners();
        }
      } on SocketException {
        state = SearchState.networkError;
      }
      state = SearchState.noResults;
    } else {
      try {
        await for (Playlist playlist in FetchingService.searchByQuery(
            query: query,
            excludedWords:
                PlaylistsService().playlists.map((pl) => pl.id).toList())) {
          if (_isCanceled) return SearchState.canceled;
          if (PlaylistsService().playlists.contains(playlist)) continue;

          playlist.setStatus(PlaylistStatus.notDownloaded);
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
