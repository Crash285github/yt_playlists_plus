import 'package:flutter/material.dart';

class ApplicationSplitPortions extends ChangeNotifier {
  //Singleton
  static final ApplicationSplitPortions _instance =
      ApplicationSplitPortions._internal();
  ApplicationSplitPortions._internal();
  factory ApplicationSplitPortions() => _instance;

  static SplitPortions _currentPortions = SplitPortions.uneven;
  static SplitPortions get() => _currentPortions;

  static set(SplitPortions portion) {
    _currentPortions = portion;
    _instance.notifyListeners();
  }
}

enum SplitPortions {
  uneven(left: 2, right: 3),
  even(left: 1, right: 1);

  const SplitPortions({required this.left, required this.right});

  final int left;
  final int right;
}
