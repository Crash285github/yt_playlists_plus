import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yt_playlists_plus/model/playlist/playlist.dart';
import 'package:yt_playlists_plus/pages/pages_export.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Persistence()),
      ChangeNotifierProvider(create: (context) => ApplicationTheme()),
    ],
    child: const MainApp(),
  ));
  Persistence.load();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ApplicationTheme>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: "Youtube Playlists+",
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        '/about': (context) => const AboutPage(),
        '/search': (context) => const SearchPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/playlist') {
          final args = settings.arguments as Playlist;
          return MaterialPageRoute(
              builder: (context) => ListenableProvider.value(
                    value: args,
                    child: const PlaylistPage(),
                  ));
        }
        return null;
      },
      theme: ApplicationTheme.get() == ApplicationTheme.light
          ? lightTheme
          : darkTheme,
    );
  }
}
