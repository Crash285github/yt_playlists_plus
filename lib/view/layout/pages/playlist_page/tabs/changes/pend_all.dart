import 'package:flutter/material.dart';

class PendAllButton extends StatelessWidget {
  final Function()? onPressed;
  const PendAllButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: const Row(
          children: [Text("Pend all"), Icon(Icons.clear_all)],
        ));
  }
}
