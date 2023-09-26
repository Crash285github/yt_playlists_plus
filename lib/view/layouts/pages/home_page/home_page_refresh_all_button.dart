import 'package:flutter/material.dart';

class HomePageRefreshAllButton extends StatelessWidget {
  final Function()? onPressed;
  final int fetchCount;

  const HomePageRefreshAllButton(
      {super.key, required this.onPressed, required this.fetchCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onPressed,
          tooltip: "Refresh all",
        ),
        fetchCount == 0
            ? const SizedBox.shrink()
            : Positioned(
                left: 15,
                bottom: 10,
                child: IgnorePointer(
                  ignoring: true,
                  child: Text("$fetchCount",
                      style: Theme.of(context).textTheme.titleSmall),
                ),
              ),
      ],
    );
  }
}
