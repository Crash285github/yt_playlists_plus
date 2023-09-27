import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/export_import_service.dart';

class PlaylistsService extends ChangeNotifier implements StorableService {
  List<Playlist> playlists = Persistence.playlists;

  void replace(List<Playlist> playlists) {
    Persistence.playlists = this.playlists = playlists;
    notifyListeners();
  }

  void add(Playlist item) {
    //?? this removes a playlist only if it has the same id
    playlists.remove(item);
    playlists.add(item);
    notifyListeners();

    Persistence.playlists = playlists;
  }

  void remove(Playlist item) {
    item.cancelNetworking();

    playlists.remove(item);
    notifyListeners();

    Persistence.playlists = playlists;
    ExportImportService().tryEnable();
  }

  @override
  String storageKey = Persistence.playlistsKey;

  @override
  Future<void> load() async =>
      Persistence.load<List<String>>(key: storageKey, defaultValue: [])
          .then((value) {
        playlists = (value as List<String>)
            .map((playlistJson) => Playlist.fromJson(jsonDecode(playlistJson)))
            .toList();
      }).whenComplete(() {
        notifyListeners();
        Persistence.playlists = playlists;
      });

  @override
  Future<bool> save() async => Persistence.save<List<String>>(
      key: storageKey,
      value: playlists.map((playlist) => jsonEncode(playlist)).toList());

  //__ Singleton
  static final PlaylistsService _instance = PlaylistsService._();
  factory PlaylistsService() => _instance;
  PlaylistsService._();
}
