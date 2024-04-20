import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class AppTheme {
  static ThemeData createTheme(Color seedColor, Brightness brightness) {
    final ColorScheme scheme = _createScheme(seedColor, brightness);
    return _createThemeData(scheme);
  }

  static ColorScheme _createScheme(Color seedColor, Brightness brightness) {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
  }

  static ThemeData _createThemeData(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      inputDecorationTheme: _createInputDecorationTheme(),
      elevatedButtonTheme: _createElevatedButtonThemeData(scheme),
      listTileTheme: _createListTileThemeData(scheme),
      appBarTheme: _createAppBarTheme(scheme),
    );
  }

  static InputDecorationTheme _createInputDecorationTheme() {
    return const InputDecorationTheme(
      border: OutlineInputBorder(),
    );
  }

  static ElevatedButtonThemeData _createElevatedButtonThemeData(
    ColorScheme scheme,
  ) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(scheme.primary),
        foregroundColor: MaterialStatePropertyAll(scheme.onPrimary),
      ),
    );
  }

  static ListTileThemeData _createListTileThemeData(ColorScheme scheme) {
    return ListTileThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      tileColor: scheme.surfaceVariant,
      textColor: scheme.onSurfaceVariant,
    );
  }

  static AppBarTheme _createAppBarTheme(ColorScheme scheme) {
    return AppBarTheme(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: scheme.background,
        statusBarIconBrightness: _getReverseBrightness(scheme.brightness),
        systemNavigationBarColor: scheme.background,
        systemNavigationBarIconBrightness: _getReverseBrightness(
          scheme.brightness,
        ),
      ),
    );
  }

  static Brightness _getReverseBrightness(Brightness brightness) {
    return brightness == Brightness.light ? Brightness.dark : Brightness.light;
  }
}
