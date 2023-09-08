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
  ///2 / 3
  uneven(left: 2, right: 3, displayName: 'Uneven'),

  ///1 / 1
  even(left: 1, right: 1, displayName: 'Even'),

  ///No split view
  disabled(left: 1, right: 1, displayName: 'Disabled'),
  ;

  const SplitPortions({
    required this.left,
    required this.right,
    required this.displayName,
  });

  final int left;
  final int right;
  final String displayName;
}
