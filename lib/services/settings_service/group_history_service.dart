import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

class GroupHistoryService extends ChangeNotifier implements SettingService {
  //Singleton
  static final GroupHistoryService _instance = GroupHistoryService._();
  factory GroupHistoryService() => _instance;
  GroupHistoryService._();

  bool groupHistoryTime = false;

  @override
  String mapKey = 'groupHistoryTime';

  @override
  Future<void> load() async =>
      set(await LoadingService.load<bool>(key: mapKey, defaultValue: false));

  @override
  Future<bool> save() async =>
      await SavingService.save<bool>(key: mapKey, value: groupHistoryTime);

  @override
  void set(value) {
    groupHistoryTime = value;
    notifyListeners();
  }
}
