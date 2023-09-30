import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/split_layout_enum.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_service.dart';

///Manages the layout of the app
class SplitLayoutService extends ChangeNotifier
    implements SettingService<SplitLayout>, StorableController {
  SplitLayout portions = Persistence.splitLayout;
  bool isEnabled = true;

  @override
  void set(SplitLayout value) {
    Persistence.splitLayout = portions = value;
    isEnabled = portions != SplitLayout.disabled;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.splitLayoutKey;

  @override
  Future<bool> save() async =>
      await Persistence.save<int>(key: storageKey, value: portions.index);

  @override
  Future<void> load() async => set(SplitLayout
      .values[await Persistence.load<int>(key: storageKey, defaultValue: 0)]);

  //__ Singleton
  static final SplitLayoutService _instance = SplitLayoutService._();
  factory SplitLayoutService() => _instance;
  SplitLayoutService._();
}
