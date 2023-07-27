import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/model/playlist.dart';
import 'package:yt_playlists_plus/pages/pages_export.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Persistence()),
    ],
    child: const MainApp(),
  ));
  Persistence().load();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/search': (context) => const SearchPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/playlist') {
          final args = settings.arguments as Playlist;
          return MaterialPageRoute(
              builder: (context) => PlaylistPage(playlist: args));
        }
        return null;
      },
      theme: ThemeData.dark(useMaterial3: true),
    );
  }
}
