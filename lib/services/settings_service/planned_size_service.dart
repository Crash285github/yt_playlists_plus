import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

///Manages the height of the Planned panel (mobile only)
class PlannedSizeService extends ChangeNotifier
    implements SettingService<PlannedSize>, StorableService {
  PlannedSize plannedSize = PlannedSize.normal;

  @override
  void set(PlannedSize value) {
    plannedSize = value;
    notifyListeners();
  }

  @override
  String storableKey = 'initialPlannedSize';

  @override
  Future<void> load() async => set(PlannedSize
      .values[await Persistence.load<int>(key: storableKey, defaultValue: 0)]);

  @override
  Future<bool> save() async =>
      await Persistence.save<int>(key: storableKey, value: plannedSize.index);

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
