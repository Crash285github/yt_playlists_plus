import 'package:flutter/material.dart';

class EmptyVideos extends StatelessWidget {
  const EmptyVideos({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          "This playlist... is empty",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
        ),
      ),
    );
  }
}
