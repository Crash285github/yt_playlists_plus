import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

class HistoryLimitService extends ChangeNotifier
    implements SettingService<int?> {
  //Singleton
  static final HistoryLimitService _instance = HistoryLimitService._();
  factory HistoryLimitService() => _instance;
  HistoryLimitService._();

  int? limit;

  @override
  String mapKey = 'historyLimit';

  @override
  Future<void> load() async {
    set(await LoadingService.load<int>(key: mapKey, defaultValue: -1));
  }

  @override
  Future<bool> save() async =>
      await SavingService.save<int>(key: mapKey, value: limit ?? -1);

  @override
  void set(int? value) {
    if (value == -1) {
      limit = null;
    } else {
      limit = value;
    }

    notifyListeners();
  }
}
