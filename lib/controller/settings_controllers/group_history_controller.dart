import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_controller.dart';

///Manages setting the history grouping
class GroupHistoryController extends SettingController<bool>
    implements StorableController {
  bool groupHistory = Persistence.groupHistory.value;

  @override
  void set(bool value) {
    groupHistory = value;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.groupHistory.key;

  @override
  Future<bool> save() async {
    Persistence.groupHistory.value = groupHistory;
    return await Persistence.save<bool>(key: storageKey, value: groupHistory);
  }

  @override
  Future<void> load() async {
    set(await Persistence.load<bool>(key: storageKey, defaultValue: false));
    Persistence.groupHistory.value = groupHistory;
  }

  //__ Singleton
  static final GroupHistoryController _instance = GroupHistoryController._();
  factory GroupHistoryController() => _instance;
  GroupHistoryController._();
}
