import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

class PlannedSizeService extends ChangeNotifier
    implements SettingService<PlannedSize> {
  //Singleton
  static final PlannedSizeService _instance = PlannedSizeService._();
  factory PlannedSizeService() => _instance;
  PlannedSizeService._();

  PlannedSize plannedSize = PlannedSize.normal;

  @override
  String mapKey = 'initialPlannedSize';

  @override
  void set(PlannedSize value) {
    plannedSize = value;
    notifyListeners();
  }

  @override
  Future<void> load() async {
    set(PlannedSize
        .values[await LoadingService.load<int>(key: mapKey, defaultValue: 0)]);
  }

  @override
  Future<bool> save() async =>
      await SavingService.save<int>(key: mapKey, value: plannedSize.index);
}

enum PlannedSize {
  ///Default value
  normal(displayName: "Default"),

  ///Lowest setting
  minimal(displayName: "Minimal"),
  ;

  const PlannedSize({required this.displayName});

  final String displayName;
}
