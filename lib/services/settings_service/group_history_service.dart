import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

///Manages setting the history grouping
class GroupHistoryService extends ChangeNotifier
    implements SettingService<bool>, StorableService {
  bool groupHistoryTime = false;

  @override
  void set(bool value) {
    groupHistoryTime = value;
    notifyListeners();
  }

  @override
  String storableKey = 'groupHistoryTime';

  @override
  Future<void> load() async =>
      set(await Persistence.load<bool>(key: storableKey, defaultValue: false));

  @override
  Future<bool> save() async =>
      await Persistence.save<bool>(key: storableKey, value: groupHistoryTime);

  //__ Singleton
  static final GroupHistoryService _instance = GroupHistoryService._();
  factory GroupHistoryService() => _instance;
  GroupHistoryService._();
}
