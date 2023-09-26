import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

class GroupHistoryService extends ChangeNotifier
    implements SettingService<bool>, StoreableService {
  bool groupHistoryTime = false;

  @override
  void set(bool value) {
    groupHistoryTime = value;
    notifyListeners();
  }

  @override
  String mapKey = 'groupHistoryTime';

  @override
  Future<void> load() async =>
      set(await LoadingService.load<bool>(key: mapKey, defaultValue: false));

  @override
  Future<bool> save() async =>
      await SavingService.save<bool>(key: mapKey, value: groupHistoryTime);

  //__ Singleton
  static final GroupHistoryService _instance = GroupHistoryService._();
  factory GroupHistoryService() => _instance;
  GroupHistoryService._();
}
