import 'package:yt_playlists_plus/enums/planned_size_enum.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_controller.dart';

///Manages the height of the Planned panel (mobile only)
class PlannedSizeController extends SettingController<PlannedSize>
    implements StorableController {
  PlannedSize plannedSize = Persistence.plannedSize.value;

  @override
  void set(PlannedSize value) {
    plannedSize = value;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.plannedSize.key;

  @override
  Future<void> load() async => set(PlannedSize
      .values[await Persistence.load<int>(key: storageKey, defaultValue: 0)]);

  @override
  Future<bool> save() async {
    Persistence.plannedSize.value = plannedSize;
    return await Persistence.save<int>(
        key: storageKey, value: plannedSize.index);
  }

  //__ Singleton
  static final PlannedSizeController _instance = PlannedSizeController._();
  factory PlannedSizeController() => _instance;
  PlannedSizeController._();
}
