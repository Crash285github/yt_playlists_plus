import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

///Manages the setting 'Hide Topics'
class HideTopicsService extends ChangeNotifier
    implements SettingService<bool>, StorableService {
  bool hideTopics = false;

  @override
  void set(bool value) {
    hideTopics = value;
    notifyListeners();
  }

  @override
  String storableKey = 'hideTopics';

  @override
  Future<void> load() async =>
      set(await Persistence.load(key: storableKey, defaultValue: false));

  @override
  Future<bool> save() async =>
      await Persistence.save<bool>(key: storableKey, value: hideTopics);

  //__ Singleton
  static final HideTopicsService _instance = HideTopicsService._();
  factory HideTopicsService() => _instance;
  HideTopicsService._();
}
