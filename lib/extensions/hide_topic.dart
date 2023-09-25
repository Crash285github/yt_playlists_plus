extension HideTopic on String {
  ///Trims a string that has a trailing '- Topic'
  String hideTopic() {
    return endsWith(" - Topic") ? substring(0, length - 8) : this;
  }
}
