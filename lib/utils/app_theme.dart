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
    return ThemeData.from(colorScheme: scheme, useMaterial3: true).copyWith(
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
        backgroundColor: WidgetStatePropertyAll(scheme.primary),
        foregroundColor: WidgetStatePropertyAll(scheme.onPrimary),
      ),
    );
  }

  static ListTileThemeData _createListTileThemeData(ColorScheme scheme) {
    return ListTileThemeData(
      shape: _createRoundedRectangleBorder(),
      tileColor: scheme.primaryContainer,
      textColor: scheme.onPrimaryContainer,
    );
  }

  static RoundedRectangleBorder _createRoundedRectangleBorder() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    );
  }

  static AppBarTheme _createAppBarTheme(ColorScheme scheme) {
    return AppBarTheme(
      centerTitle: true,
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: scheme.surface.withOpacity(0.9),
      systemOverlayStyle: _createSystemUiOverlayStyle(scheme),
    );
  }

  static SystemUiOverlayStyle _createSystemUiOverlayStyle(ColorScheme scheme) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: _getReverseBrightness(scheme.brightness),
      systemNavigationBarColor: scheme.surface.withOpacity(0.6),
      systemNavigationBarIconBrightness: _getReverseBrightness(
        scheme.brightness,
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
