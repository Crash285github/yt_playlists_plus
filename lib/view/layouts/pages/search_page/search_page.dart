import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/controller/searching_controller.dart';
import 'package:yt_playlists_plus/view/layouts/pages/search_page/empty.dart';
import 'package:yt_playlists_plus/view/layouts/pages/search_page/results.dart';
import 'package:yt_playlists_plus/view/layouts/pages/search_page/search_bar.dart';
import 'package:yt_playlists_plus/view/bottom_padding.dart';
import 'package:yt_playlists_plus/view/templates/styled_sliver_app_bar.dart';

///Page used for looking up and downloading playlists
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String message = "Search for a playlist here!";

  @override
  Widget build(BuildContext context) {
    SearchingController service = Provider.of<SearchingController>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          StyledSliverAppBar(
            pinned: true,
            snap: false,
            title: const Text("Search Playlists"),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight + 40),
              child: SearchPageSearchBar(
                progress: service.progress / 20,
                isEmpty: service.searchResults.isEmpty,
                isSearching: service.isSearching,
                onSubmitted: (value) async {
                  await service.search(query: value).then((SearchState state) {
                    if (state == SearchState.canceled) return;
                    setState(() {
                      message = state.message ?? "";
                    });
                  });
                },
              ),
            ),
          ),
          ...service.searchResults.isEmpty && !service.isSearching
              ? [EmptySearchPage(message: message)]
              : [
                  SearchResults(results: service.searchResults),
                  const SliverToBoxAdapter(child: AdaptiveHeightBox())
                ]
        ],
      ),
    );
  }
}
