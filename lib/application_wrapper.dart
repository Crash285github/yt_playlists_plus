import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/services/settings_service/color_scheme_service.dart';
import 'package:yt_playlists_plus/services/settings_service/theme_service.dart';
import 'package:yt_playlists_plus/view/responsive/responsive.dart';

///Builds the application with a theme
class ThemeBuilder extends StatelessWidget {
  const ThemeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeService>(context);
    Provider.of<ColorSchemeService>(context);
    final AppColorScheme appColorScheme = ColorSchemeService().scheme;

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme? lightColorScheme;
        ColorScheme? darkColorScheme;

        //?? dynamic color schemes
        if (appColorScheme == AppColorScheme.dynamic) {
          lightColorScheme = lightDynamic?.harmonized();
          darkColorScheme = darkDynamic?.harmonized();
        }
        //?? static color schemes
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
            seedColor: ColorSchemeService().scheme.color!,
          );

          darkColorScheme = ColorScheme.fromSeed(
            seedColor: ColorSchemeService().scheme.color!,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: "Youtube Playlists+",
          home: const Responsive(),
          debugShowCheckedModeBanner: false,
          theme: ThemeService().builder(
            scheme: ThemeService().theme == AppTheme.light
                ? lightColorScheme
                : darkColorScheme,
          ),
        );
      },
    );
  }
}
