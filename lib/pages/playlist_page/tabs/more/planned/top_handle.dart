import 'package:flutter/material.dart';

class TopHandle extends StatelessWidget {
  const TopHandle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
