import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yt_playlists_plus/persistence/initial_planned_size.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';

///The Application's Persistent Storage
///
///It implements the Singleton Design Pattern
class Persistence with ChangeNotifier {
  //? Singleton Design Pattern
  static final Persistence _instance = Persistence._internal();
  Persistence._internal();
  factory Persistence() => _instance;

  //#region Playlist data

  ///The currently stored Playlists
  ///
  ///Requires Persistence.load() to get the data
  static Set<Playlist> get playlists => _playlists;
  static Set<Playlist> _playlists = {}; //private representation

  ///Adds a `Playlist` item to the Persistent storage, and alerts listeners
  ///
  ///Doesn't save on it's own
  static void addPlaylist(Playlist item) {
    if (_playlists.contains(item)) {
      //playlist videos can be different, == only checks ids
      _playlists.remove(item);
    }

    _playlists.add(item);
    _instance.notifyListeners();
  }

  ///Removes a `Playlist` item from the Persistent storage, and alerts listeners
  ///
  ///Doesn't save on its own
  static void removePlaylist(Playlist item) {
    _playlists.remove(item);
    _instance.notifyListeners();
  }

  //#endregion

  ///Whether to show a confirmation dialog before deleting playlists
  static bool confirmDeletions = true;

  ///The height of planned list initially
  static InitialPlannedSize initialPlannedSize = InitialPlannedSize.normal;

  ///Loads the Persistent Storage, and alerts listeners when finished
  static Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //? theme
    ApplicationTheme.set(prefs.getInt('theme') ?? 0);

    //? confirmDeletions
    confirmDeletions = prefs.getBool('confirmDeletions') ?? true;

    //? initialPlannedSize
    initialPlannedSize =
        InitialPlannedSize.values[prefs.getInt('initialPlannedSize') ?? 0];

    //? playlists
    List<String> val = prefs.getStringList('playlists') ?? [];
    if (val.isEmpty) return;

    _playlists = val.map((e) => Playlist.fromJson(jsonDecode(e))).toSet();
    _instance.notifyListeners();
  }

  static Future<bool> saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('theme', ApplicationTheme.get());
  }

  static Future<bool> saveConfirmDeletions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool('confirmDeletions', confirmDeletions);
  }

  static Future<bool> saveInitialPlannedSize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('initialPlannedSize', initialPlannedSize.index);
  }

  static Future<bool> savePlaylists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(
        'playlists', (_playlists.map((e) => jsonEncode(e))).toList());
  }
}
