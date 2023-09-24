import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/services/abstract_saveable.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';

class PlaylistsService extends ChangeNotifier implements SaveableService {
  //Singleton
  static final PlaylistsService _instance = PlaylistsService._();
  factory PlaylistsService() => _instance;
  PlaylistsService._();

  List<Playlist> playlists = [];

  void add(Playlist item) {
    //?? this removes a playlist only if it has the same id
    playlists.remove(item);

    playlists.add(item);
    notifyListeners();
  }

  void remove(Playlist item) {
    item.cancelNetworking();

    playlists.remove(item);
    notifyListeners();
  }

  @override
  String mapKey = 'playlists';

  @override
  Future<void> load() async {
    LoadingService.load<List<String>>(key: mapKey, defaultValue: [])
        .then((value) {
      playlists = (value as List<String>)
          .map((playlistJson) => Playlist.fromJson(jsonDecode(playlistJson)))
          .toList();
    }).then((_) => notifyListeners());
  }

  @override
  Future<bool> save() async => SavingService.save<List<String>>(
      key: mapKey,
      value: playlists.map((playlist) => jsonEncode(playlist)).toList());
}
