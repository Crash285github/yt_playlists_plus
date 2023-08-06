import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';
import 'package:yt_playlists_plus/widgets/planned_widget.dart';

class PlannedList extends StatefulWidget {
  final Set<String> planned;
  final PanelController controller;

  const PlannedList({
    super.key,
    required this.planned,
    required this.controller,
  });

  @override
  State<PlannedList> createState() => _PlannedListState();
}

class _PlannedListState extends State<PlannedList> {
  late TextEditingController _dialogController;

  @override
  void initState() {
    _dialogController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _dialogController.dispose();
    super.dispose();
  }

  bool canSubmitPlanned(String title) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (title.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Can't be empty",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          showCloseIcon: true,
          closeIconColor: ApplicationTheme.get() == ApplicationTheme.light
              ? Colors.black
              : Colors.white,
          backgroundColor: Theme.of(context).cardTheme.color,
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.none,
          margin: const EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      );

      return false;
    }

    if (widget.planned.contains(title)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Already exists",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
          ),
          showCloseIcon: true,
          closeIconColor: Colors.white,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );

      return false;
    }

    return true;
  }

  Future<String?> openDialog() async {
    _dialogController.clear();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add new planned video"),
        content: TextField(
          decoration: const InputDecoration(
            label: Text("Enter title"),
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          controller: _dialogController,
          onSubmitted: (value) {
            Navigator.of(context).pop(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(_dialogController.text);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      color: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      child: ListView(
        children: [
          GestureDetector(
            //? isPanelOpen always returned false, so had to find a workaround
            onTap: () => widget.controller.panelPosition.round() == 1
                ? widget.controller.close()
                : widget.controller.open(),
            child: Container(
              height: 30,
              color: Colors.transparent,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 5,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Planned (${widget.planned.length})",
                    style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: "Add",
                  onPressed: () async {
                    final String? title = await openDialog();
                    if (title == null) return;
                    if (canSubmitPlanned(title)) {
                      setState(() {
                        widget.planned.add(title);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          const Divider(
            indent: 10,
            endIndent: 10,
          ),
          ...widget.planned.map((title) => PlannedWidget(
                title: title,
                onDeletePressed: () {
                  setState(() {
                    widget.planned.remove(title);
                  });
                },
              )),
          const SizedBox(height: 80)
        ],
      ),
    );
  }
}
