import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class AppTheme {
  static const defaultColor = Colors.blueAccent;
  static final defaultLightColorScheme = ColorScheme.fromSeed(
    seedColor: defaultColor,
    brightness: Brightness.light,
  );
  static final defaultDarkColorScheme = ColorScheme.fromSeed(
    seedColor: defaultColor,
    brightness: Brightness.dark,
  );

  static ThemeData createThemeData(ColorScheme scheme) {
    return ThemeData.from(
      colorScheme: scheme,
      useMaterial3: true,
    );
  }

  static SystemUiOverlayStyle createSystemUiOverlayStyle(BuildContext context) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: _getReverseBrightness(
        Theme.of(context).colorScheme.brightness,
      ),
      systemNavigationBarColor: _hasGestures(context)
          ? Colors.transparent
          : Theme.of(context).colorScheme.surface.withOpacity(0.75),
      systemNavigationBarIconBrightness: _getReverseBrightness(
        Theme.of(context).colorScheme.brightness,
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
