import 'package:flutter/material.dart';

class EmptySearchPage extends StatelessWidget {
  final String message;
  const EmptySearchPage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.grey),
        ),
      )),
    );
  }
}
