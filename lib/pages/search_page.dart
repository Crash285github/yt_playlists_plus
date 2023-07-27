import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/widgets/widgets_export.dart';

import '../model/client.dart';
import '../model/playlist.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final YoutubeClient _client = YoutubeClient();

  bool _isSearching = false;
  String _searchQuery = "";

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  List<Playlist> _searchResults = [];

  Future<void> _search() async {
    setState(() {
      _isSearching = true;
      _searchResults = [];
    });

    await for (Playlist list in _client.searchPlaylists(_searchQuery)) {
      setState(() {
        _searchResults.add(list);
      });
    }

    setState(() {
      _isSearching = false;
    });
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
