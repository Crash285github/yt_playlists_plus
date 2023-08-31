import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yt_playlists_plus/pages/pages_export.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/persistence/color_scheme.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';
import 'package:yt_playlists_plus/responsive/responsive.dart';

void main() async {
  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    await windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setSize(const Size(1100, 900));
      await windowManager.setMinimumSize(const Size(600, 400));
      await windowManager.setAlignment(Alignment.center);
      await windowManager.show();
    });
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Persistence()),
      ChangeNotifierProvider(create: (context) => ApplicationTheme()),
    ],
    child: const YPPApp(),
  ));
  Persistence.load();
}

class YPPApp extends StatelessWidget {
  const YPPApp({super.key});

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    if ((query.orientation == Orientation.portrait && query.size.width < 500) ||
        query.size.height < 500) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

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
