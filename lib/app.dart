import 'package:flutter/material.dart';
import 'package:super_task_list/utils/app_routes.dart';
import 'package:super_task_list/utils/app_theme.dart';
import 'package:system_theme/system_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemThemeBuilder(
      builder: (context, accent) => MaterialApp.router(
        title: 'Super Lista de Tarefas',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        darkTheme: AppTheme.createTheme(
          accent.accent,
          Brightness.dark,
        ),
        theme: AppTheme.createTheme(
          accent.accent,
          Brightness.light,
        ),
        routerConfig: AppRoutes.router,
      ),
    );
  }
}
