import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

class SplitLayoutService extends ChangeNotifier
    implements SettingService<SplitLayout> {
  //Singleton
  static final SplitLayoutService _instance = SplitLayoutService._();
  factory SplitLayoutService() => _instance;
  SplitLayoutService._();

  bool isEnabled = true;
  SplitLayout portions = SplitLayout.uneven;

  @override
  void set(SplitLayout value) {
    portions = value;
    isEnabled = portions != SplitLayout.disabled;
    notifyListeners();
  }

  @override
  String mapKey = 'splitLayout';

  @override
  Future<bool> save() async =>
      await SavingService.save<int>(key: mapKey, value: portions.index);

  @override
  Future<void> load() async {
    set(SplitLayout
        .values[await LoadingService.load<int>(key: mapKey, defaultValue: 0)]);
  }
}

enum SplitLayout {
  ///2 / 3
  uneven(left: 2, right: 3, displayName: 'Uneven'),

  ///1 / 1
  even(left: 1, right: 1, displayName: 'Even'),

  ///No split view
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
