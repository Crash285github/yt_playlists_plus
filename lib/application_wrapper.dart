import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/persistence/color_scheme.dart';
import 'package:yt_playlists_plus/persistence/theme.dart';
import 'package:yt_playlists_plus/responsive/responsive.dart';

class ApplicationWrapper extends StatelessWidget {
  const ApplicationWrapper({super.key});

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
