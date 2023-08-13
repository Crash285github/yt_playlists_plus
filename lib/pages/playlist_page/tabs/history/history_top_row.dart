import 'package:flutter/material.dart';

class HistoryTopRow extends StatelessWidget {
  final Function()? onClearPressed;

  const HistoryTopRow({
    super.key,
    required this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "History",
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
    );
  }
}
