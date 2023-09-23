extension HideTopic on String {
  ///Trims a string that has a trailing '- Topic'
  String hideTopic() {
    return endsWith(" - Topic") ? substring(0, length - 8) : this;
  }
}

extension EqualSecondsSinceEpoch on DateTime {
  bool equalSecondsSinceEpoch(DateTime other) {
    return millisecondsSinceEpoch ~/ 1000 ==
        other.millisecondsSinceEpoch ~/ 1000;
  }
}
