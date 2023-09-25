import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/services/search_service.dart';
import 'package:yt_playlists_plus/view/pages/search_page/empty.dart';
import 'package:yt_playlists_plus/view/pages/search_page/results.dart';
import 'package:yt_playlists_plus/view/pages/search_page/search_bar.dart';
import 'package:yt_playlists_plus/view/widgets/bottom_padding.dart';
import 'package:yt_playlists_plus/view/widgets/preset_sliver_app_bar.dart';

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
    SearchService service = Provider.of<SearchService>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            pinned: true,
            snap: false,
            title: const Text("Search Playlists"),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(85),
              child: SearchPageSearchBar(
                progress: service.progress / 20,
                isEmpty: service.searchResults.isEmpty,
                isSearching: service.isSearching,
                onSubmitted: (value) async {
                  await service
                      .search(query: value)
                      .then((SearchState state) => setState(() {
                            message = state.message ?? "";
                          }));
                },
              ),
            ),
          ),
          ...service.searchResults.isEmpty && !service.isSearching
              ? [EmptySearchPage(message: message)]
              : [
                  SearchResults(results: service.searchResults),
                  const SliverFillRemaining(hasScrollBody: false),
                  const SliverToBoxAdapter(child: BottomPadding())
                ]
        ],
      ),
    );
  }
}
