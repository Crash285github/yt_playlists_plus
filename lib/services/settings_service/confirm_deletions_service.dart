import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

///Manages the delete confirmations setting
class ConfirmDeletionsService extends ChangeNotifier
    implements SettingService<bool>, StorableService {
  bool confirmDeletions = true;

  @override
  void set(bool value) {
    confirmDeletions = value;
    notifyListeners();
  }

  @override
  String storableKey = 'confirmDeletions';

  @override
  Future<void> load() async =>
      set(await Persistence.load<bool>(key: storableKey, defaultValue: true));

  @override
  Future<bool> save() async =>
      await Persistence.save<bool>(key: storableKey, value: confirmDeletions);

  //__ Singleton
  static final ConfirmDeletionsService _instance = ConfirmDeletionsService._();
  factory ConfirmDeletionsService() => _instance;
  ConfirmDeletionsService._();
}
