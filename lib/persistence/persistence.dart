import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/playlist.dart';

///The Application's Persistent Storage
class Persistence with ChangeNotifier {
  Set<Playlist> _playlists = {};

  ///The currently stored Playlists
  ///
  ///Requires persistence.load() first
  Set<Playlist> get playlists => _playlists;

  ///Adds a `Playlist` item to the Persistent storage, and alerts listeners
  ///
  ///Doesn't save on it's own
  void addPlaylist(Playlist item) {
    if (_playlists.contains(item)) {
      //playlist videos can be different, == only checks ids
      _playlists.remove(item);
    }

    _playlists.add(item);
    notifyListeners();
  }

  ///Removes a `Playlist` item from the Persistent storage, and alerts listeners
  ///
  ///Doesn't save on it's own
  void removePlaylist(Playlist item) {
    _playlists.remove(item);
    notifyListeners();
  }

  ///Loads the Persistent Storage, and alerts listeners when finished
  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> val = prefs.getStringList('playlists') ?? [];
    if (val.isEmpty) return;

    _playlists = val.map((e) => Playlist.fromJson(jsonDecode(e))).toSet();
    notifyListeners();
  }

  ///Saves current Persistent Storage state
  Future<bool> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setStringList(
        'playlists', (_playlists.map((e) => jsonEncode(e))).toList());
  }
}
