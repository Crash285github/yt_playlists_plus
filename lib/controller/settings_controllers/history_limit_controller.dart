import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yt_playlists_plus/model/persistence.dart';
import 'package:yt_playlists_plus/controller/abstract_storeable.dart';
import 'package:yt_playlists_plus/services/popup_service/open_textfield_dialog.dart';
import 'package:yt_playlists_plus/services/popup_service/popup_service.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/abstract_setting_controller.dart';

///Manages the history limit
class HistoryLimitController extends SettingController<int?>
    implements StorableController {
  int? limit = Persistence.historyLimit.value;
  final TextEditingController _controller = TextEditingController();

  @override
  void set(int? value) {
    if (value == null || value < 0) {
      limit = null;
    } else {
      limit = value;
    }
    notifyListeners();
  }

  @override
  String storageKey = Persistence.historyLimit.key;

  @override
  Future<void> load() async =>
      set(await Persistence.load<int>(key: storageKey, defaultValue: -1));

  @override
  Future<bool> save() async {
    Persistence.historyLimit.value = limit;
    return await Persistence.save<int>(key: storageKey, value: limit ?? -1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///Opens a `TextField` to input an int value
  Future<int?> openDialog(BuildContext context) async {
    String? result = await PopUpService().openTextFieldDialog(
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
  static final HistoryLimitController _instance = HistoryLimitController._();
  factory HistoryLimitController() => _instance;
  HistoryLimitController._();
}
