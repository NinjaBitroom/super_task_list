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

  static ThemeData createThemeData(ColorScheme scheme, BuildContext context) {
    return ThemeData.from(colorScheme: scheme, useMaterial3: true).copyWith(
      appBarTheme: _createAppBarTheme(scheme, context),
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
