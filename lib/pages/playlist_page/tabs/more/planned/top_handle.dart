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
        color: Colors.transparent,
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            height: 5,
            width: 20,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
