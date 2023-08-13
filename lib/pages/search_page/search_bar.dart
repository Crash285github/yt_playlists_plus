import 'package:flutter/material.dart';

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
  final FocusNode _focusNode = FocusNode();

  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              //? TextField
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  controller: _textEditingController,
                  enabled: !widget.isSearching,
                  decoration: const InputDecoration(
                    label: Text("Search playlists..."),
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: widget.onSubmitted,
                ),
              ),
              //? Button or Indicator
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: widget.isSearching
                      ? widget.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : Center(
                              child: TweenAnimationBuilder(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              tween: Tween<double>(
                                  begin: widget.isSearching ? 0 : 1,
                                  end: widget.progress),
                              builder: (context, value, _) =>
                                  CircularProgressIndicator(value: value),
                            ))
                      : Center(
                          child: IconButton(
                            onPressed: () =>
                                widget.onSubmitted(_textEditingController.text),
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
