import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

class HideTopicsService extends ChangeNotifier
    implements SettingService<bool>, StoreableService {
  bool hideTopics = false;

  @override
  void set(bool value) {
    hideTopics = value;
    notifyListeners();
  }

  @override
  String mapKey = 'hideTopics';

  @override
  Future<void> load() async =>
      set(await LoadingService.load(key: mapKey, defaultValue: false));

  @override
  Future<bool> save() async =>
      await SavingService.save<bool>(key: mapKey, value: hideTopics);

  //__ Singleton
  static final HideTopicsService _instance = HideTopicsService._();
  factory HideTopicsService() => _instance;
  HideTopicsService._();
}
