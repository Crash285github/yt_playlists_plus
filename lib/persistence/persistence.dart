import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/playlist.dart';

class Persistence with ChangeNotifier {
  Set<Playlist> _playlists = {};

  Set<Playlist> get playlists => _playlists;

  void addItem(Playlist item) {
    if (_playlists.contains(item)) {
      //playlist videos can be different, == only checks ids
      _playlists.remove(item);
    }

    _playlists.add(item);
    notifyListeners();
  }

  void removeItem(Playlist item) {
    _playlists.remove(item);
    notifyListeners();
  }

  Future<void> loadPersistence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> val = prefs.getStringList('playlists') ?? [];
    if (val.isEmpty) return;

    _playlists = val.map((e) => Playlist.fromJson(jsonDecode(e))).toSet();
    notifyListeners();
  }

  Future<bool> savePersistence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setStringList(
        'playlists', (_playlists.map((e) => jsonEncode(e))).toList());
  }
}
