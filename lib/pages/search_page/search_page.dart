import 'dart:io';
import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/pages/search_page/empty.dart';
import 'package:yt_playlists_plus/pages/search_page/results.dart';
import 'package:yt_playlists_plus/pages/search_page/search_bar.dart';
import 'package:yt_playlists_plus/services/playlists_service.dart';
import 'package:yt_playlists_plus/widgets/preset_sliver_app_bar.dart';
import 'package:yt_playlists_plus/model/client.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isSearching = false;
  bool _rendered = true; //? required to stop searching after leaving the page
  String _searchQuery = "";

  double _progress = 0;
  late String _placeholder;

  List<Playlist> _searchResults = [];

  Future<void> _search() async {
    _placeholder = "No results found.";

    setState(() {
      _isSearching = true;
      _searchResults = [];
      _progress = 0;
    });

    if (_isYoutubePlaylistLink(query: _searchQuery.trim())) {
      try {
        YoutubeClient();
        Playlist? playlist =
            await YoutubeClient.searchByLink(url: _searchQuery.trim());
        if (playlist != null) {
          playlist.setStatus(PlaylistStatus.notDownloaded);
          _searchResults.add(playlist);
        }
      } on SocketException {
        //? do nothing
      }
    } else {
      try {
        YoutubeClient();
        await for (Playlist playlist in YoutubeClient.searchByQuery(
          query: _searchQuery,
          excludedWords: PlaylistsService().playlists.map((e) => e.id).toList(),
        )) {
          if (!_rendered) return;
          if (PlaylistsService().playlists.contains(playlist)) continue;

          playlist.setStatus(PlaylistStatus.notDownloaded);
          setState(() {
            _searchResults.add(playlist);
            _progress++;
          });
        }
      } on SocketException {
        //? do nothing
      }
    }

    setState(() {
      _isSearching = false;
      _progress = 20;
    });
  }

  @override
  void initState() {
    _placeholder = "Search for a playlist here!";
    super.initState();
  }

  @override
  void dispose() {
    _rendered = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          PresetSliverAppBar(
            pinned: true,
            snap: false,
            title: const Text("Search Playlists"),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(85),
              child: SearchPageSearchBar(
                progress: _progress / 20,
                isEmpty: _searchResults.isEmpty,
                isSearching: _isSearching,
                onSubmitted: (value) async {
                  setState(() {
                    _searchQuery = value;
                  });
                  await _search();
                },
              ),
            ),
          ),
          _searchResults.isEmpty && !_isSearching
              ? EmptySearchPage(message: _placeholder)
              : SearchResults(results: _searchResults)
        ],
      ),
    );
  }

  bool _isYoutubePlaylistLink({required String query}) {
    final youtubeLinkRegExp = RegExp(
        r"^(https?:\/\/)?((www|m)\.)?youtu(.?)be\.com\/playlist\?list=.{34}");

    return youtubeLinkRegExp.hasMatch(query);
  }
}
