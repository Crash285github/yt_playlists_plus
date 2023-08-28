import 'package:flutter/material.dart';

class TopHandle extends StatelessWidget {
  final Function()? onTap;

  const TopHandle({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        color: Colors.transparent, //? required for tap-detection
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            height: 5,
            width: 20,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
