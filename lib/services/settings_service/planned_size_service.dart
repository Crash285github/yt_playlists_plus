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
  String dataKey = 'initialPlannedSize';

  @override
  Future<void> load() async {
    set(PlannedSize
        .values[await LoadingService.loadInt(key: dataKey, defaultValue: 0)]);
  }

  @override
  Future<bool> save() async =>
      SavingService.saveInt(key: dataKey, value: plannedSize.index);

  @override
  void set(PlannedSize plannedSize) {
    this.plannedSize = plannedSize;
    notifyListeners();
  }
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

