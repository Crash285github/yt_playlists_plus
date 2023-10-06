import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/config.dart';

class SearchPageSearchBar extends StatefulWidget {
  final double progress;
  final Function(String) onSubmitted;
  final bool isSearching;
  final bool isEmpty;

  const SearchPageSearchBar({
    super.key,
    required this.progress,
    required this.isSearching,
    required this.isEmpty,
    required this.onSubmitted,
  });

  @override
  State<SearchPageSearchBar> createState() => _SearchPageSearchBarState();
}

class _SearchPageSearchBarState extends State<SearchPageSearchBar> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConfig.spacing),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //?? TextField
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 100),
                child: SizedBox(
                  width: AppConfig.mobileMaxWidth,
                  child: TextField(
                    focusNode: focusNode,
                    controller: textEditingController,
                    enabled: !widget.isSearching,
                    decoration: InputDecoration(
                        label: const Text("Search playlists..."),
                        border: const OutlineInputBorder(),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconButton(
                              onPressed: () {
                                textEditingController.clear();
                                focusNode.requestFocus();
                              },
                              icon: const Icon(Icons.clear)),
                        )),
                    onSubmitted: widget.onSubmitted,
                  ),
                ),
              ),
              //?? Button or Indicator
              Padding(
                padding: const EdgeInsets.only(left: AppConfig.spacing),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: widget.isSearching
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                          child: IconButton(
                            onPressed: () =>
                                widget.onSubmitted(textEditingController.text),
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
    );
  }
}
