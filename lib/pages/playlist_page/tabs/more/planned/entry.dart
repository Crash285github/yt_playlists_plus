import 'package:flutter/material.dart';

class PlannedWidget extends StatefulWidget {
  final String title;
  final Function onDeletePressed;
  const PlannedWidget({
    super.key,
    required this.title,
    required this.onDeletePressed,
  });

  @override
  State<PlannedWidget> createState() => _PlannedWidgetState();
}

class _PlannedWidgetState extends State<PlannedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Tooltip(
              message: widget.title,
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          IconButton(
            onPressed: () => widget.onDeletePressed(),
            icon: const Icon(Icons.remove),
            color: Colors.red,
            tooltip: "Remove",
          ),
        ],
      ),
    );
  }
}
