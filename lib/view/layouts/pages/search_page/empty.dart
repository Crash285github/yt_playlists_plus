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
          child: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
      )),
    );
  }
}
