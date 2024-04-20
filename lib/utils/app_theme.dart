import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class AppTheme {
  static ThemeData createTheme(Color seedColor, Brightness brightness) {
    final ColorScheme scheme = createScheme(seedColor, brightness);
    return createThemeData(scheme);
  }

  static ColorScheme createScheme(Color seedColor, Brightness brightness) {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
  }

  static ThemeData createThemeData(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      inputDecorationTheme: _createInputDecorationTheme(),
      elevatedButtonTheme: _createElevatedButtonThemeData(scheme),
      listTileTheme: _createListTileThemeData(scheme),
      appBarTheme: _createAppBarTheme(scheme),
      floatingActionButtonTheme: _createFloatingActionButtonTheme(scheme),
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
      tileColor: scheme.primaryContainer,
      textColor: scheme.onPrimaryContainer,
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

  static FloatingActionButtonThemeData _createFloatingActionButtonTheme(
    ColorScheme scheme,
  ) {
    return FloatingActionButtonThemeData(
      backgroundColor: scheme.tertiaryContainer,
      foregroundColor: scheme.onTertiaryContainer,
    );
  }

  static Brightness _getReverseBrightness(Brightness brightness) {
    return brightness == Brightness.light ? Brightness.dark : Brightness.light;
  }
}
