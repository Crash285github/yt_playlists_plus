import 'package:flutter/material.dart';

class MoreTopRow extends StatelessWidget {
  final int length;
  const MoreTopRow({
    super.key,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        "Videos: ($length)",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
