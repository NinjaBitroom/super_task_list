import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:super_task_list/utils/app_routes.dart';
import 'package:super_task_list/utils/app_theme.dart';

final class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final lightTheme = AppTheme.createThemeData(
            lightDynamic ?? AppTheme.defaultLightColorScheme, context);
        final darkTheme = AppTheme.createThemeData(
            darkDynamic ?? AppTheme.defaultDarkColorScheme, context);
        return MaterialApp.router(
          title: 'Super Lista de Tarefas',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: lightTheme,
          darkTheme: darkTheme,
          routerConfig: AppRoutes.router,
        );
      },
    );
  }
}
