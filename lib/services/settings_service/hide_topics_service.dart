import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

///Manages the setting 'Hide Topics'
class HideTopicsService extends ChangeNotifier
    implements SettingService<bool>, StorableService {
  bool hideTopics = Persistence.hideTopics;

  @override
  void set(bool value) {
    Persistence.hideTopics = hideTopics = value;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.hideTopicsKey;

  @override
  Future<void> load() async =>
      set(await Persistence.load(key: storageKey, defaultValue: false));

  @override
  Future<bool> save() async =>
      await Persistence.save<bool>(key: storageKey, value: hideTopics);

  //__ Singleton
  static final HideTopicsService _instance = HideTopicsService._();
  factory HideTopicsService() => _instance;
  HideTopicsService._();
}
