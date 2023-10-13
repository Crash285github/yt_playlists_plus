import 'package:yt_playlists_plus/enums/app_color_scheme_enum.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_controller.dart';

///Manages the application's color scheme
class ColorSchemeController extends SettingController<AppColorScheme>
    implements StorableController {
  AppColorScheme scheme = Persistence.colorScheme.value;

  @override
  void set(AppColorScheme value) {
    scheme = value;
    notifyListeners();
  }

  @override
  String storageKey = Persistence.colorScheme.key;

  @override
  Future<bool> save() async =>
      Persistence.save<int>(key: storageKey, value: scheme.index);

  @override
  Future<void> load() async {
    set(AppColorScheme
        .values[await Persistence.load<int>(key: storageKey, defaultValue: 0)]);
    Persistence.colorScheme.value = scheme;
  }

  //__ Singleton
  static final ColorSchemeController _instance = ColorSchemeController._();
  factory ColorSchemeController() => _instance;
  ColorSchemeController._();
}
