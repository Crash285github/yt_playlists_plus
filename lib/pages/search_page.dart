import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/widgets/widgets_export.dart';

import '../model/client.dart';
import '../model/playlist.dart';
import '../persistence/persistence.dart';

class SearchPage extends StatefulWidget {
  final Persistence persistence;
  const SearchPage({super.key, required this.persistence});

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

    await for (Playlist list in _client.searchPlaylists(
        query: _searchQuery,
        excludedWords:
            widget.persistence.playlists.map((e) => e.id).toList())) {
      if (!_rendered) return;
      if (widget.persistence.playlists.contains(list)) continue;
      setState(() {
        _searchResults.add(list);
      });
    }

    setState(() {
      _isSearching = false;
    });
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
          customSliverAppBar("Search Playlists"),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _searchField(),
                ),
                ..._searchResults
                    .map((e) => PlaylistWidget(
                          playlist: e,
                          persistence: widget.persistence,
                          onTap: () => widget.persistence.addPlaylist(e),
                        ))
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
              width: 70,
              height: 70,
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
                        icon: const Icon(Icons.send),
                        iconSize: 30,
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
            ),
          ),
        ],
      );
  //#endregion
}
