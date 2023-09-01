import 'package:flutter/material.dart';

class HistoryTopRow extends StatelessWidget {
  final Function()? onClearPressed;
  final int size;

  const HistoryTopRow({
    super.key,
    required this.onClearPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "History ($size)",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          TextButton(
            onPressed: onClearPressed,
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("Clear"), Icon(Icons.clear)],
            ),
          )
        ],
      ),
    );
  }
}
