import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yt_playlists_plus/enums/app_color_scheme_enum.dart';
import 'package:yt_playlists_plus/enums/app_theme_enum.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/color_scheme_controller.dart';
import 'package:yt_playlists_plus/controller/settings_controllers/theme_controller.dart';
import 'package:yt_playlists_plus/view/layouts/responsive/responsive.dart';

///Builds the application with a theme
class ThemeBuilder extends StatelessWidget {
  static const tooltipTheme =
      TooltipThemeData(waitDuration: Duration(seconds: 1));

  static const cardTheme = CardTheme(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
  );

  static const dividerTheme = DividerThemeData(
    indent: 10,
    endIndent: 10,
    space: 2,
  );

  static final snackBarTheme = SnackBarThemeData(
    showCloseIcon: true,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    insetPadding: const EdgeInsets.all(15),
    elevation: 0,
  );

  static const buttonPadding =
      MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.all(16));

  const ThemeBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeController>(context);
    AppColorScheme scheme = Provider.of<ColorSchemeController>(context).scheme;

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme? lightColorScheme;
        ColorScheme? darkColorScheme;

        //?? dynamic color schemes
        if (scheme == AppColorScheme.dynamic) {
          lightColorScheme = lightDynamic?.harmonized();
          darkColorScheme = darkDynamic?.harmonized();
        }
        //?? static color schemes
        else if (scheme == AppColorScheme.mono) {
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
            seedColor: scheme.color!,
          );

          darkColorScheme = ColorScheme.fromSeed(
            seedColor: scheme.color!,
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: "Youtube Playlists+",
          home: const Responsive(),
          debugShowCheckedModeBanner: false,
          theme: ThemeController().builder(
            scheme: ThemeController().theme == AppTheme.light
                ? lightColorScheme
                : darkColorScheme,
          ),
        );
      },
    );
  }
}
