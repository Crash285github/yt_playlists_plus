import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_service.dart';

///Manages the delete confirmations setting
class ConfirmDeletionsService extends ChangeNotifier
    implements SettingService<bool>, StorableController {
  bool confirmDeletions = Persistence.confirmDeletions.value;

  @override
  void set(bool value) {
    confirmDeletions = value;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.confirmDeletions.key;

  @override
  Future<void> load() async =>
      set(await Persistence.load<bool>(key: storageKey, defaultValue: true));

  @override
  Future<bool> save() async {
    Persistence.confirmDeletions.value = confirmDeletions;
    return await Persistence.save<bool>(
        key: storageKey, value: confirmDeletions);
  }

  //__ Singleton
  static final ConfirmDeletionsService _instance = ConfirmDeletionsService._();
  factory ConfirmDeletionsService() => _instance;
  ConfirmDeletionsService._();
}
