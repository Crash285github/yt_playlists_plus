import 'package:yt_playlists_plus/model/client.dart';

void main(List<String> args) async {
  var client = YoutubeClient();
  await for (var list in client.searchPlaylists("@crash285")) {
    print(list);
  }
  client.close();
}
