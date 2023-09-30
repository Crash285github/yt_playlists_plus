import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_service.dart';

///Manages the setting 'Hide Topics'
class HideTopicsService extends ChangeNotifier
    implements SettingService<bool>, StorableController {
  bool hideTopics = Persistence.hideTopics.value;

  @override
  void set(bool value) {
    hideTopics = value;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.hideTopics.key;

  @override
  Future<void> load() async =>
      set(await Persistence.load(key: storageKey, defaultValue: false));

  @override
  Future<bool> save() async {
    Persistence.hideTopics.value = hideTopics;
    return await Persistence.save<bool>(key: storageKey, value: hideTopics);
  }

  //__ Singleton
  static final HideTopicsService _instance = HideTopicsService._();
  factory HideTopicsService() => _instance;
  HideTopicsService._();
}
