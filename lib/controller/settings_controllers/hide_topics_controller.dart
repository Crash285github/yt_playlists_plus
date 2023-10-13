import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_controller.dart';

///Manages the setting 'Hide Topics'
class HideTopicsController extends SettingController<bool>
    implements StorableController {
  bool hideTopics = Persistence.hideTopics.value;

  @override
  void set(bool value) {
    hideTopics = value;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.hideTopics.key;

  @override
  Future<bool> save() async {
    Persistence.hideTopics.value = hideTopics;
    return await Persistence.save<bool>(key: storageKey, value: hideTopics);
  }

  @override
  Future<void> load() async {
    set(await Persistence.load(key: storageKey, defaultValue: false));
    Persistence.hideTopics.value = hideTopics;
  }

  //__ Singleton
  static final HideTopicsController _instance = HideTopicsController._();
  factory HideTopicsController() => _instance;
  HideTopicsController._();
}
