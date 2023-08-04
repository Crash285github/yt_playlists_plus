import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/widgets/planned_widget.dart';

class PlannedList extends StatefulWidget {
  final Set<String> planned;
  const PlannedList({
    super.key,
    required this.planned,
  });

  @override
  State<PlannedList> createState() => _PlannedListState();
}

class _PlannedListState extends State<PlannedList> {
  late bool _isExpanded;
  late TextEditingController _dialogController;

  @override
  void initState() {
    _isExpanded = false;
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
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Can't be empty",
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
    double expandedTileChildrenHeight =
        MediaQuery.of(context).size.height - (kToolbarHeight * 6);
    if (expandedTileChildrenHeight < 0) expandedTileChildrenHeight = 0;

    return Card(
      margin: const EdgeInsets.all(10),
      child: ExpansionTile(
        title: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _isExpanded
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                width: 2,
              ),
            ),
          ),
          child: Text("Planned (${widget.planned.length})",
              style: Theme.of(context).textTheme.titleLarge),
        ),
        trailing: IconButton(
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
        onExpansionChanged: (value) => setState(() {
          _isExpanded = value;
        }),
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: expandedTileChildrenHeight),
            child: ListView(
              shrinkWrap: true,
              children: [
                ...widget.planned.map((title) => PlannedWidget(
                      title: title,
                      onDeletePressed: () {
                        setState(() {
                          widget.planned.remove(title);
                        });
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
