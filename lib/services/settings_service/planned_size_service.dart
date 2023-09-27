import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/enums/planned_size_enum.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

///Manages the height of the Planned panel (mobile only)
class PlannedSizeService extends ChangeNotifier
    implements SettingService<PlannedSize>, StorableService {
  PlannedSize plannedSize = Persistence.plannedSize;

  @override
  void set(PlannedSize value) {
    Persistence.plannedSize = plannedSize = value;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.plannedSizeKey;

  @override
  Future<void> load() async => set(PlannedSize
      .values[await Persistence.load<int>(key: storageKey, defaultValue: 0)]);

  @override
  Future<bool> save() async =>
      await Persistence.save<int>(key: storageKey, value: plannedSize.index);

  //__ Singleton
  static final PlannedSizeService _instance = PlannedSizeService._();
  factory PlannedSizeService() => _instance;
  PlannedSizeService._();
}
