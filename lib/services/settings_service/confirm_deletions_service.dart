import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

class ConfirmDeletionsService extends ChangeNotifier
    implements SettingService<bool>, StoreableService {
  bool confirmDeletions = true;

  @override
  void set(bool value) {
    confirmDeletions = value;
    notifyListeners();
  }

  @override
  String mapKey = 'confirmDeletions';

  @override
  Future<void> load() async =>
      set(await LoadingService.load<bool>(key: mapKey, defaultValue: true));

  @override
  Future<bool> save() async =>
      await SavingService.save<bool>(key: mapKey, value: confirmDeletions);

  //__ Singleton
  static final ConfirmDeletionsService _instance = ConfirmDeletionsService._();
  factory ConfirmDeletionsService() => _instance;
  ConfirmDeletionsService._();
}
