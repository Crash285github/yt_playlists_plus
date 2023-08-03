import 'package:flutter/material.dart';

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

  @override
  void initState() {
    _isExpanded = [false];
    super.initState();
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
                  child: Text(
                    "Planned",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              );
            },
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...widget.planned.map(
                  (title) => Text(title),
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
