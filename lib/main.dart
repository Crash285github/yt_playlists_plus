import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/persistence/color_scheme.dart';
import 'package:yt_playlists_plus/persistence/persistence.dart';
import 'package:yt_playlists_plus/persistence/split_portions.dart';
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
      ChangeNotifierProvider(create: (context) => ApplicationColorScheme()),
      ChangeNotifierProvider(create: (context) => ApplicationSplitPortions()),
    ],
    child: const YPPApp(),
  ));

  Persistence.load();
}

class YPPApp extends StatelessWidget {
  const YPPApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ApplicationTheme>(context);
    Provider.of<ApplicationColorScheme>(context);
    final ApplicationColor appColorScheme = ApplicationColorScheme.get();

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme? lightColorScheme;
        ColorScheme? darkColorScheme;

        //? dynamic color schemes
        if (appColorScheme == ApplicationColor.dynamic) {
          lightColorScheme = lightDynamic?.harmonized();
          darkColorScheme = darkDynamic?.harmonized();
        }
        //? static color schemes
        else if (appColorScheme == ApplicationColor.mono) {
          lightColorScheme = const ColorScheme.light().copyWith(
            primary: Colors.black,
            secondary: Colors.black,
            surfaceTint: Colors.black,
            primaryContainer: Colors.grey,
          );

          darkColorScheme = const ColorScheme.dark().copyWith(
            primary: Colors.white,
            secondary: Colors.white,
            surfaceTint: Colors.white,
            primaryContainer: Colors.grey,
          );
        } else {
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: ApplicationColorScheme.get().color!,
          );

          darkColorScheme = ColorScheme.fromSeed(
            seedColor: ApplicationColorScheme.get().color!,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: "Youtube Playlists+",
          home: const Responsive(),
          debugShowCheckedModeBanner: false,
          theme: ApplicationTheme.get() == ApplicationTheme.light
              ? themeBuilder(scheme: lightColorScheme)
              : themeBuilder(scheme: darkColorScheme),
        );
      },
    );
  }
}
