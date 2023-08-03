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
  late final List<bool> _isExpanded;
  late TextEditingController _dialogController;

  @override
  void initState() {
    _isExpanded = [false];
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 0),
        children: [
          ExpansionPanel(
            canTapOnHeader: true,
            backgroundColor: Colors.transparent,
            headerBuilder: (context, isExpanded) {
              return Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Planned (${widget.planned.length})",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => setState(() {
                              widget.planned.clear();
                            }),
                            child: Row(children: [
                              const Icon(
                                Icons.clear,
                                color: Colors.red,
                              ),
                              Text(
                                "Clear",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.red),
                              ),
                            ]),
                          ),
                          TextButton(
                            onPressed: () async {
                              final String title = await openDialog() ?? "";
                              if (canSubmitPlanned(title)) {
                                setState(() {
                                  widget.planned.add(title);
                                });
                              }
                            },
                            child: Row(children: [
                              const Icon(
                                Icons.add,
                                color: Colors.red,
                              ),
                              Text(
                                "Add",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.red),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...widget.planned.map(
                  (title) => PlannedWidget(
                      title: title,
                      onDeletePressed: () {
                        setState(() {
                          widget.planned.remove(title);
                        });
                      }),
                ),
              ],
            ),
            isExpanded: _isExpanded[0],
          ),
        ],
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            _isExpanded[panelIndex] = !isExpanded;
          });
        },
      ),
    );
  }
}
