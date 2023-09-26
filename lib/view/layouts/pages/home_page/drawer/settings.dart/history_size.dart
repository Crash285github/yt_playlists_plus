import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yt_playlists_plus/services/popup_controller/open_textfield_dialog.dart';
import 'package:yt_playlists_plus/services/popup_controller/popup_controller.dart';
import 'package:yt_playlists_plus/services/settings_service/history_limit_service.dart';

class HistoryLimitSetting extends StatefulWidget {
  const HistoryLimitSetting({super.key});

  @override
  State<HistoryLimitSetting> createState() => _HistoryLimitSettingState();
}

class _HistoryLimitSettingState extends State<HistoryLimitSetting> {
  late TextEditingController _textEditingController;
  int? historySize = HistoryLimitService().limit;
  int topLimit = 500; //? before infinite
  int bottomLimit = 10;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        int? result = int.tryParse(await PopUpController().openTextFieldDialog(
              context: context,
              controller: _textEditingController,
              title: "Set history limit",
              submitLabel: "Set",
              label: "Enter a number",
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            ) ??
            "");

        if (result == null) return;

        if (result > topLimit) {
          result = null;
        } else if (result < bottomLimit) {
          result = 10;
        }

        setState(() {
          historySize = result;
        });

        HistoryLimitService()
          ..set(historySize)
          ..save();
      },
      leading: const Icon(Icons.manage_history),
      title: const Text("History limit"),
      subtitle: Text(
        "Between $bottomLimit and $topLimit, \nor infinite if above.",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
      ),
      trailing: Text(
        "${historySize ?? "Infinite"}",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
      ),
    );
  }
}
