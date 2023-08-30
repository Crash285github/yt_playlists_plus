import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yt_playlists_plus/model/popup_manager.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

class HistorySizeSetting extends StatefulWidget {
  const HistorySizeSetting({super.key});

  @override
  State<HistorySizeSetting> createState() => _HistorySizeSettingState();
}

class _HistorySizeSettingState extends State<HistorySizeSetting> {
  late TextEditingController _textEditingController;
  int? historySize = Persistence.historyLimit;
  int topLimit = 500; //? before infinite

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
        int? result = int.tryParse(await PopUpManager.openTextFieldDialog(
              context: context,
              controller: _textEditingController,
              title: "Set history limit",
              submitLabel: "Set",
              label: "Enter a number",
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ) ??
            "");

        if (result == null) return;

        if (result > topLimit) {
          result = null;
        }

        setState(() {
          historySize = result;
        });

        Persistence.historyLimit = historySize;
        Persistence.saveHistoryLimit();
      },
      leading: const Icon(Icons.history),
      title: const Text("History limit"),
      subtitle: Text(
        "Between 0 and $topLimit",
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
