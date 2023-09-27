extension EqualSecondsSinceEpoch on DateTime {
  bool equalSecondsSinceEpoch(DateTime other) {
    return millisecondsSinceEpoch ~/ 1000 ==
        other.millisecondsSinceEpoch ~/ 1000;
  }
}
