import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  final Function()? onAddPressed;
  final int length;
  const TitleRow({
    super.key,
    required this.onAddPressed,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Planned ($length)",
            style: Theme.of(context).textTheme.titleLarge),
        IconButton(
          icon: const Icon(Icons.add),
          tooltip: "Add",
          onPressed: onAddPressed,
        ),
      ],
    );
  }
}
