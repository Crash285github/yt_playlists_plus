import 'package:youtube_explode_dart/youtube_explode_dart.dart' show PlaylistId;

extension IsYoutubeLink on String {
  bool isYoutubePlaylistLink() {
    return PlaylistId.validatePlaylistId(
        PlaylistId.parsePlaylistId(this) ?? "");
  }
}
