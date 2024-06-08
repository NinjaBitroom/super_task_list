import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class AppTheme {
  static ThemeData getThemeData(ColorScheme? scheme, ThemeData fallback) {
    return scheme != null ? _createThemeData(scheme) : fallback;
  }

  static SystemUiOverlayStyle createSystemUiOverlayStyle(BuildContext context) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: _getReverseBrightness(context),
      systemNavigationBarColor: _getColorForSystemNavigationBar(context),
      systemNavigationBarIconBrightness: _getReverseBrightness(context),
    );
  }

  static ThemeData _createThemeData(ColorScheme scheme) {
    return ThemeData.from(
      colorScheme: _createColorScheme(scheme),
      useMaterial3: true,
    );
  }

  static ColorScheme _createColorScheme(ColorScheme scheme) {
    return ColorScheme.fromSeed(
      seedColor: scheme.primary,
      brightness: scheme.brightness,
    );
  }

  static Brightness _getReverseBrightness(BuildContext context) {
    return Theme.of(context).colorScheme.brightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;
  }

  static bool _hasGestures(BuildContext context) {
    return MediaQuery.of(context).systemGestureInsets.left > 0;
  }

  static Color _getSurfaceColorWithOpacity(BuildContext context) {
    return Theme.of(context).colorScheme.surface.withOpacity(0.75);
  }

  static Color _getColorForSystemNavigationBar(BuildContext context) {
    return _hasGestures(context)
        ? Colors.transparent
        : _getSurfaceColorWithOpacity(context);
  }
}
