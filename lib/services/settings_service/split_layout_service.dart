import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

///Manages the layout of the app
class SplitLayoutService extends ChangeNotifier
    implements SettingService<SplitLayout>, StorableService {
  SplitLayout portions = SplitLayout.uneven;
  bool isEnabled = true;

  @override
  void set(SplitLayout value) {
    portions = value;
    isEnabled = portions != SplitLayout.disabled;
    notifyListeners();
  }

  @override
  String storableKey = 'splitLayout';

  @override
  Future<bool> save() async =>
      await Persistence.save<int>(key: storableKey, value: portions.index);

  @override
  Future<void> load() async => set(SplitLayout
      .values[await Persistence.load<int>(key: storableKey, defaultValue: 0)]);

  //__ Singleton
  static final SplitLayoutService _instance = SplitLayoutService._();
  factory SplitLayoutService() => _instance;
  SplitLayoutService._();
}

enum SplitLayout {
  uneven(left: 2, right: 3, displayName: 'Uneven'),
  even(left: 1, right: 1, displayName: 'Even'),
  disabled(left: 1, right: 1, displayName: 'Disabled'),
  ;

  const SplitLayout({
    required this.left,
    required this.right,
    required this.displayName,
  });

  final int left;
  final int right;
  final String displayName;

  String toJson() => name;
  static SplitLayout fromJson(String json) => values.byName(json);
}
