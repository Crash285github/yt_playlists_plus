import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/pages/pages.dart';

void main() => runApp(const MainApp());

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
        '/playlist': (context) => const PlaylistPage(),
      },
      theme: ThemeData.dark(useMaterial3: true),
    );
  }
}
