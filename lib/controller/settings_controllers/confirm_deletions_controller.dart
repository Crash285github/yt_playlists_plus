import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_controller.dart';

///Manages the delete confirmations setting
class ConfirmDeletionsController extends SettingController<bool>
    implements StorableController {
  bool confirmDeletions = Persistence.confirmDeletions.value;

  @override
  void set(bool value) {
    confirmDeletions = value;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.confirmDeletions.key;

  @override
  Future<void> load() async =>
      set(await Persistence.load<bool>(key: storageKey, defaultValue: true));

  @override
  Future<bool> save() async {
    Persistence.confirmDeletions.value = confirmDeletions;
    return await Persistence.save<bool>(
        key: storageKey, value: confirmDeletions);
  }

  //__ Singleton
  static final ConfirmDeletionsController _instance =
      ConfirmDeletionsController._();
  factory ConfirmDeletionsController() => _instance;
  ConfirmDeletionsController._();
}
