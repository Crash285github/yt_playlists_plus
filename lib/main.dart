import 'package:flutter/material.dart';
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
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Persistence persistence = Provider.of<Persistence>(context);
    persistence.load();
    
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(persistence: persistence),
        '/about': (context) => const AboutPage(),
        '/search': (context) => SearchPage(persistence: persistence),
        '/playlist': (context) => const PlaylistPage(),
      },
      theme: ThemeData.dark(useMaterial3: true),
    );
  }
}
