class PlaylistException implements Exception {
  final String message;

  PlaylistException(this.message);

  @override
  String toString() {
    return 'PlaylistException: $message';
  }
}
