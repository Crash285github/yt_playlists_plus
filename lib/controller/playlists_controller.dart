import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/export_import_controller.dart';

class PlaylistsService extends ChangeNotifier implements StorableController {
  List<PlaylistController> playlists = Persistence.playlists;

  void replace(List<PlaylistController> playlists) {
    Persistence.playlists = this.playlists = playlists;
    notifyListeners();
  }

  void add(PlaylistController item) {
    //?? this removes a playlist only if it has the same id
    playlists.remove(item);
    playlists.add(item);
    notifyListeners();

    Persistence.playlists = playlists;
  }

  void remove(PlaylistController item) {
    item.cancelNetworking();

    playlists.remove(item);
    notifyListeners();

    Persistence.playlists = playlists;
    ExportImportController().tryEnable();
  }

  @override
  String storageKey = Persistence.playlistsKey;

  @override
  Future<void> load() async =>
      Persistence.load<List<String>>(key: storageKey, defaultValue: [])
          .then((value) {
        playlists = (value as List<String>)
            .map((playlistJson) =>
                PlaylistController.fromJson(jsonDecode(playlistJson)))
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
