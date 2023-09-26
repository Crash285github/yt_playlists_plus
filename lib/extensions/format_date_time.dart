extension FormatDateTime on DateTime {
  ///Converts a DateTime to a String format like this:
  ///
  ///2023. Oct. 23. 12:03:23
  String formatted() {
    final String month = switch (this.month) {
      1 => 'Jan.',
      2 => 'Feb.',
      3 => 'Mar.',
      4 => 'Apr.',
      5 => 'May.',
      6 => 'Jun.',
      7 => 'Jul.',
      8 => 'Aug.',
      9 => 'Sep.',
      10 => 'Oct.',
      11 => 'Nov.',
      12 => 'Dec.',
      _ => 'error'
    };

    String addZeroIfBelow10(int time) => "${time > 9 ? time : '0$time'}";

    return "$year. $month $day. ${addZeroIfBelow10(hour)}:${addZeroIfBelow10(minute)}:${addZeroIfBelow10(second)}";
  }
}
