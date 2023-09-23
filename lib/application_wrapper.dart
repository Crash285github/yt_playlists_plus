import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/services/color_scheme_service.dart';
import 'package:yt_playlists_plus/services/theme_service.dart';
import 'package:yt_playlists_plus/responsive/responsive.dart';

class ApplicationWrapper extends StatelessWidget {
  const ApplicationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AppThemeService>(context);
    Provider.of<AppColorSchemeService>(context);
    final AppColorScheme appColorScheme = AppColorSchemeService().scheme;

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme? lightColorScheme;
        ColorScheme? darkColorScheme;

        //? dynamic color schemes
        if (appColorScheme == AppColorScheme.dynamic) {
          lightColorScheme = lightDynamic?.harmonized();
          darkColorScheme = darkDynamic?.harmonized();
        }
        //? static color schemes
        else if (appColorScheme == AppColorScheme.mono) {
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
            seedColor: AppColorSchemeService().scheme.color!,
          );

          darkColorScheme = ColorScheme.fromSeed(
            seedColor: AppColorSchemeService().scheme.color!,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: "Youtube Playlists+",
          home: const Responsive(),
          debugShowCheckedModeBanner: false,
          theme: AppThemeService().theme == AppTheme.light
              ? themeBuilder(scheme: lightColorScheme)
              : themeBuilder(scheme: darkColorScheme),
        );
      },
    );
  }
}
