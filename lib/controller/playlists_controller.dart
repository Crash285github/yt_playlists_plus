import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/playlist_controller.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/export_import_controller.dart';

class PlaylistsController extends ChangeNotifier implements StorableController {
  List<PlaylistController> playlists = Persistence.playlists.value
      .map((e) => PlaylistController(playlist: e))
      .toList();

  void replace(List<PlaylistController> playlists) {
    this.playlists = playlists;
    notifyListeners();
  }

  void add(PlaylistController item) {
    //?? this removes a playlist only if it has the same id
    playlists.remove(item);
    playlists.add(item);
    notifyListeners();
  }

  void remove(PlaylistController item) {
    item.cancelNetworking();

    playlists.remove(item);
    notifyListeners();

    ExportImportController().tryEnable();
  }

  @override
  String storageKey = Persistence.playlists.key;

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
      });

  @override
  Future<bool> save() async {
    Persistence.playlists.value = playlists.map((e) => e.playlist).toList();
    return Persistence.save<List<String>>(
        key: storageKey,
        value: playlists.map((playlist) => jsonEncode(playlist)).toList());
  }

  //__ Singleton
  static final PlaylistsController _instance = PlaylistsController._();
  factory PlaylistsController() => _instance;
  PlaylistsController._();
}
