import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/widgets/widgets_export.dart';

import '../model/client.dart';
import '../model/playlist/playlist.dart';
import '../persistence/persistence.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final YoutubeClient _client = YoutubeClient();

  bool _isSearching = false;
  bool _rendered = true; //required to stop searching after leaving the page
  String _searchQuery = "";

  //SearchBar linking with Button & _searchQuery
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  List<Playlist> _searchResults = [];

  Future<void> _search() async {
    setState(() {
      _isSearching = true;
      _searchResults = [];
    });

    if (_isYoutubePlaylistLink(query: _searchQuery)) {
      Playlist? playlist = await _client.searchByLink(url: _searchQuery);
      if (playlist != null) {
        playlist.setStatus(PlaylistStatus.notDownloaded);
        _searchResults.add(playlist);
      }
    } else {
      await for (Playlist playlist in _client.searchByQuery(
        query: _searchQuery,
        excludedWords: Persistence.playlists.map((e) => e.id).toList(),
      )) {
        if (!_rendered) return;
        if (Persistence.playlists.contains(playlist)) continue;
        playlist.setStatus(PlaylistStatus.notDownloaded);
        setState(() {
          _searchResults.add(playlist);
        });
      }
    }

    setState(() {
      _isSearching = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _rendered = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          customSliverAppBar(title: "Search Playlists"),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _searchField(),
                ),
                ..._searchResults
                    .map(
                      (e) => ListenableProvider.value(
                        value: e,
                        child: PlaylistWidget(
                          onTap: () async {
                            Persistence.addPlaylist(e);
                            await e.download();
                            await Persistence.save();
                          },
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //#region SearchBar
  _searchField() => Row(
        children: [
          //TextField
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              controller: _controller,
              enabled: !_isSearching,
              decoration: const InputDecoration(
                label: Text("Search playlists..."),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) async {
                setState(() {
                  _searchQuery = value;
                });
                await _search();
              },
            ),
          ),
          //Button or Indicator
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: 60,
              height: 60,
              child: _isSearching
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: IconButton(
                        onPressed: () async {
                          _focusNode.unfocus();
                          setState(() {
                            _searchQuery = _controller.text;
                          });
                          await _search();
                        },
                        icon: const Icon(Icons.search),
                        iconSize: 30,
                        tooltip: "Search",
                      ),
                    ),
            ),
          ),
        ],
      );
  //#endregion

  bool _isYoutubePlaylistLink({required String query}) {
    final youtubeLinkRegExp = RegExp(
        r"^(https?:\/\/)?((www|m)\.)?youtu(.?)be\.com\/playlist\?list=.{34}$");

    return youtubeLinkRegExp.hasMatch(query);
  }
}
