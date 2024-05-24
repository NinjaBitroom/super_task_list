import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class AppTheme {
  static const defaultLightColorScheme = ColorScheme.light();
  static const defaultDarkColorScheme = ColorScheme.dark();
  static const defaultHighContrastLightColorScheme =
      ColorScheme.highContrastLight();
  static const defaultHighContrastDarkColorScheme =
      ColorScheme.highContrastDark();

  static ThemeData createTheme(
      Color seedColor, Brightness brightness, BuildContext context) {
    final ColorScheme scheme = createScheme(seedColor, brightness);
    return createThemeData(scheme, context);
  }

  static ColorScheme createScheme(Color seedColor, Brightness brightness) {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
  }

  static ThemeData createThemeData(ColorScheme scheme, BuildContext context) {
    return ThemeData.from(colorScheme: scheme, useMaterial3: true).copyWith(
      inputDecorationTheme: _createInputDecorationTheme(),
      appBarTheme: _createAppBarTheme(scheme, context),
    );
  }

  static InputDecorationTheme _createInputDecorationTheme() {
    return const InputDecorationTheme(
      border: OutlineInputBorder(),
    );
  }

  static AppBarTheme _createAppBarTheme(
      ColorScheme scheme, BuildContext context) {
    return AppBarTheme(
      centerTitle: true,
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: scheme.surface.withOpacity(0.9),
      systemOverlayStyle: _createSystemUiOverlayStyle(scheme, context),
    );
  }

  static SystemUiOverlayStyle _createSystemUiOverlayStyle(
      ColorScheme scheme, BuildContext context) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: _getReverseBrightness(scheme.brightness),
      systemNavigationBarColor: _hasGestures(context)
          ? Colors.transparent
          : scheme.surface.withOpacity(0.75),
      systemNavigationBarIconBrightness: _getReverseBrightness(
        scheme.brightness,
      ),
    );
  }

  static _hasGestures(BuildContext context) {
    return MediaQuery.of(context).systemGestureInsets.left > 0;
  }

  static Brightness _getReverseBrightness(Brightness brightness) {
    return brightness == Brightness.light ? Brightness.dark : Brightness.light;
  }
}
