import 'package:flutter/material.dart';
import 'package:super_task_list/app_routes.dart';
import 'package:super_task_list/utils/app_theme.dart';
import 'package:system_theme/system_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estudando',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.getTheme(
        SystemTheme.accentColor.accent,
        Brightness.dark,
      ),
      theme: AppTheme.getTheme(
        SystemTheme.accentColor.accent,
        Brightness.light,
      ),
      routes: AppRoutes.define(),
      initialRoute: AppRoutes.signInPage,
    );
  }
}
