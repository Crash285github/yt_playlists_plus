import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/services/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/popup_controller/open_textfield_dialog.dart';
import 'package:yt_playlists_plus/services/popup_controller/popup_controller.dart';
import 'package:yt_playlists_plus/services/settings_service/abstract_setting_service.dart';

///Manages the history limit
class HistoryLimitService extends ChangeNotifier
    implements SettingService<int?>, StorableService {
  int? limit = Persistence.historyLimit;
  final TextEditingController _controller = TextEditingController();

  @override
  void set(int? value) {
    if (value == null || value < 0) {
      Persistence.historyLimit = limit = null;
    } else {
      Persistence.historyLimit = limit = value;
    }

    notifyListeners();
  }

  @override
  String storageKey = Persistence.historyLimitKey;

  @override
  Future<void> load() async =>
      set(await Persistence.load<int>(key: storageKey, defaultValue: -1));

  @override
  Future<bool> save() async =>
      await Persistence.save<int>(key: storageKey, value: limit ?? -1);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///Opens a `TextField` to input an int value
  Future<int?> openDialog(BuildContext context) async {
    String? result = await PopUpController().openTextFieldDialog(
      context: context,
      controller: _controller,
      title: "Set history limit",
      submitLabel: "Set",
      label: "Enter a number",
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
    );

    return int.tryParse(result ?? "");
  }

  //__ Singleton
  static final HistoryLimitService _instance = HistoryLimitService._();
  factory HistoryLimitService() => _instance;
  HistoryLimitService._();
}
