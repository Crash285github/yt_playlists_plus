import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:yt_playlists_plus/pages/pages_export.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/persistence/color_scheme.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';
import 'package:yt_playlists_plus/responsive/responsive.dart';

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

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme? lightDynamicColorScheme;
        ColorScheme? darkDynamicColorScheme;

        if (Persistence.color != ApplicationColor.dynamic) {
          lightDynamicColorScheme =
              ColorScheme.fromSeed(seedColor: Persistence.color.color!);
          darkDynamicColorScheme = ColorScheme.fromSeed(
              seedColor: Persistence.color.color!, brightness: Brightness.dark);
        } else if (lightDynamic != null && darkDynamic != null) {
          lightDynamicColorScheme = lightDynamic.harmonized();
          darkDynamicColorScheme = darkDynamic.harmonized();
        }

        return MaterialApp(
          title: "Youtube Playlists+",
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const Responsive(),
            '/about': (context) => const AboutPage(),
            '/search': (context) => const SearchPage(),
          },
          theme: ApplicationTheme.get() == ApplicationTheme.light
              ? themeBuilder(scheme: lightDynamicColorScheme)
              : themeBuilder(scheme: darkDynamicColorScheme),
        );
      },
    );
  }
}
