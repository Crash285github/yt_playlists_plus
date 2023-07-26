import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isSearching = false;
  String _searchQuery = "";

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  Future<void> _search() async {
    setState(() {
      _isSearching = true;
    });

    //TODO: search here
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Search Playlists"),
            centerTitle: true,
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          focusNode: _focusNode,
                          controller: _controller,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                          width: 70,
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
                  ),
                ),
                Text(_searchQuery),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
