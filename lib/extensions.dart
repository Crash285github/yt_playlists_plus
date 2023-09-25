import 'package:youtube_explode_dart/youtube_explode_dart.dart' show PlaylistId;

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

extension FormatDateTime on DateTime {
  ///Converts a DateTime to this String format:
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

extension IsYoutubeLink on String {
  bool isYoutubePlaylistLink() {
    return PlaylistId.validatePlaylistId(
        PlaylistId.parsePlaylistId(this) ?? "");
  }
}
