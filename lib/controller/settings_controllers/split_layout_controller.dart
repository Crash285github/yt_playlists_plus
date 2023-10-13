import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/enums/split_layout_enum.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_controller.dart';

///Manages the layout of the app
class SplitLayoutController extends SettingController<SplitLayout>
    implements StorableController {
  SplitLayout portions = Persistence.splitLayout.value;
  bool isEnabled = true;

  static GlobalKey<NavigatorState> leftKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> rightKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> centralKey = GlobalKey<NavigatorState>();

  @override
  void set(SplitLayout value) {
    portions = value;
    isEnabled = portions != SplitLayout.disabled;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.splitLayout.key;

  @override
  Future<bool> save() async {
    Persistence.splitLayout.value = portions;
    return await Persistence.save<int>(key: storageKey, value: portions.index);
  }

  @override
  Future<void> load() async {
    set(SplitLayout
        .values[await Persistence.load<int>(key: storageKey, defaultValue: 0)]);
    Persistence.splitLayout.value = portions;
  }

  //__ Singleton
  static final SplitLayoutController _instance = SplitLayoutController._();
  factory SplitLayoutController() => _instance;
  SplitLayoutController._();
}
