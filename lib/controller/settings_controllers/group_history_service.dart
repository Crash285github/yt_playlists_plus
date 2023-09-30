import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_service.dart';

///Manages setting the history grouping
class GroupHistoryService extends ChangeNotifier
    implements SettingService<bool>, StorableController {
  bool groupHistory = Persistence.groupHistory;

  @override
  void set(bool value) {
    Persistence.groupHistory = groupHistory = value;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.groupHistoryKey;

  @override
  Future<void> load() async =>
      set(await Persistence.load<bool>(key: storageKey, defaultValue: false));

  @override
  Future<bool> save() async =>
      await Persistence.save<bool>(key: storageKey, value: groupHistory);

  //__ Singleton
  static final GroupHistoryService _instance = GroupHistoryService._();
  factory GroupHistoryService() => _instance;
  GroupHistoryService._();
}
