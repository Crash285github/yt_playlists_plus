import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/services/settings_service/history_limit_service.dart';

class HistoryLimitSetting extends StatefulWidget {
  const HistoryLimitSetting({super.key});

  @override
  State<HistoryLimitSetting> createState() => _HistoryLimitSettingState();
}

class _HistoryLimitSettingState extends State<HistoryLimitSetting> {
  TextEditingController textEditingController = TextEditingController();
  int? historySize = HistoryLimitService().limit;
  int topLimit = 500; //?? infinite if bigger
  int bottomLimit = 10;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5));

    return ListTile(
      onTap: () async {
        int? result = await HistoryLimitService().openDialog(context);

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
        style: textStyle,
      ),
      trailing: Text(
        "${historySize ?? "Infinite"}",
        style: textStyle,
      ),
    );
  }
}
