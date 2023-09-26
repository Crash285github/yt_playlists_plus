import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/loading_service.dart';
import 'package:yt_playlists_plus/services/saving_service.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

///Manages the height of the Planned panel (mobile only)
class PlannedSizeService extends ChangeNotifier
    implements SettingService<PlannedSize>, StoreableService {
  PlannedSize plannedSize = PlannedSize.normal;

  @override
  void set(PlannedSize value) {
    plannedSize = value;
    notifyListeners();
  }

  @override
  String mapKey = 'initialPlannedSize';

  @override
  Future<void> load() async => set(PlannedSize
      .values[await LoadingService.load<int>(key: mapKey, defaultValue: 0)]);

  @override
  Future<bool> save() async =>
      await SavingService.save<int>(key: mapKey, value: plannedSize.index);

  //__ Singleton
  static final PlannedSizeService _instance = PlannedSizeService._();
  factory PlannedSizeService() => _instance;
  PlannedSizeService._();
}

enum PlannedSize {
  normal(displayName: "Default"),
  minimal(displayName: "Minimal"),
  ;

  const PlannedSize({required this.displayName});

  final String displayName;
}
