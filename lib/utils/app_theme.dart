import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final class AppTheme {
  static ThemeData getTheme(Color seedColor, Brightness brightness) {
    final scheme = _getScheme(seedColor, brightness);
    return ThemeData(
      useMaterial3: true,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: scheme.background,
          statusBarIconBrightness: _getReverseBrightness(scheme.brightness),
          systemNavigationBarColor: scheme.background,
          systemNavigationBarIconBrightness: _getReverseBrightness(
            scheme.brightness,
          ),
        ),
      ),
      colorScheme: scheme,
    );
  }

  static ColorScheme _getScheme(Color seedColor, Brightness brightness) {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
  }

  static Brightness _getReverseBrightness(Brightness brightness) {
    return brightness == Brightness.light ? Brightness.dark : Brightness.light;
  }
}
