import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/model/playlist/playlist_status.dart';
import 'package:yt_playlists_plus/widgets/playlist_widget.dart';
import 'package:yt_playlists_plus/widgets/preset_sliver_app_bar.dart';
import 'package:yt_playlists_plus/model/client.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

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

  double _progress = 0;

  late String _placeholder;

  //SearchBar linking with Button & _searchQuery
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

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
        Playlist? playlist =
            await _client.searchByLink(url: _searchQuery.trim());
        if (playlist != null) {
          playlist.setStatus(PlaylistStatus.notDownloaded);
          _searchResults.add(playlist);
        }
      } on SocketException catch (_) {
        //? do nothing
      }
    } else {
      try {
        await for (Playlist playlist in _client.searchByQuery(
          query: _searchQuery,
          excludedWords: Persistence.playlists.map((e) => e.id).toList(),
        )) {
          if (!_rendered) return;
          if (Persistence.playlists.contains(playlist)) continue;
          playlist.setStatus(PlaylistStatus.notDownloaded);
          setState(() {
            _searchResults.add(playlist);
            _progress++;
          });
        }
      } on SocketException catch (_) {
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
    _controller.dispose();
    _rendered = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          PresetSliverAppBar(
            title: const Text("Search Playlists"),
            bottom: _searchField(progress: _progress / 20),
          ),
          _searchResults.isEmpty && !_isSearching
              ? SliverFillRemaining(
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      _placeholder,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.grey),
                    ),
                  )),
                )
              : SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ..._searchResults.map(
                        (playlist) {
                          index++;
                          return ListenableProvider.value(
                            value: playlist,
                            child: PlaylistWidget(
                                firstOfList: index == 1,
                                lastOfList: index == _searchResults.length,
                                onTap: () async {
                                  if (playlist.status ==
                                      PlaylistStatus.notDownloaded) {
                                    try {
                                      await playlist.download();
                                      Persistence.addPlaylist(playlist);
                                    } on SocketException catch (_) {
                                      Persistence.removePlaylist(playlist);
                                    } finally {
                                      await Persistence.save();
                                    }
                                  }
                                }),
                          );
                        },
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  //#region SearchBar

  _searchField({required double progress}) => PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
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
                          ? _searchResults.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : Center(
                                  child: TweenAnimationBuilder(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                  tween: Tween<double>(
                                      begin: _isSearching ? 0 : 1,
                                      end: progress),
                                  builder: (context, value, _) =>
                                      CircularProgressIndicator(value: value),
                                ))
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
              ),
            ],
          ),
        ),
      );
  //#endregion

  bool _isYoutubePlaylistLink({required String query}) {
    final youtubeLinkRegExp = RegExp(
        r"^(https?:\/\/)?((www|m)\.)?youtu(.?)be\.com\/playlist\?list=.{34}$");

    return youtubeLinkRegExp.hasMatch(query);
  }
}
