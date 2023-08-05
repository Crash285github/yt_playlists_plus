import 'package:flutter/material.dart';

abstract class ICardWidget extends StatelessWidget {
  ///If true, the card will have rounded corners on the top half
  final bool firstOfList;

  ///If true, the card will have rounded corners on the bottom half
  final bool lastOfList;

  const ICardWidget({
    super.key,
    this.firstOfList = false,
    this.lastOfList = false,
  });
}
