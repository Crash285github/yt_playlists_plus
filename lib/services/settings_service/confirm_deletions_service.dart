import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

class ConfirmDeletionsService extends ChangeNotifier
    implements SettingService<bool> {
  //Singleton
  static final ConfirmDeletionsService _instance = ConfirmDeletionsService._();
  factory ConfirmDeletionsService() => _instance;
  ConfirmDeletionsService._();

  bool confirmDeletions = true;

  @override
  String mapKey = 'confirmDeletions';

  @override
  void set(bool value) {
    confirmDeletions = value;
    notifyListeners();
  }

  @override
  Future<void> load() async {
    set(await LoadingService.load<bool>(key: mapKey, defaultValue: true));
  }

  @override
  Future<bool> save() async =>
      await SavingService.save<bool>(key: mapKey, value: confirmDeletions);
}
