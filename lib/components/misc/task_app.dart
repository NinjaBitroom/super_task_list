import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/providers/task_provider.dart';
import 'package:super_task_list/utils/app_router.dart';
import 'package:super_task_list/utils/app_theme.dart';

final class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return MaterialApp.router(
            title: 'Super Lista de Tarefas',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: ThemeData.from(
              colorScheme: lightDynamic ?? AppTheme.defaultLightColorScheme,
            ),
            darkTheme: ThemeData.from(
              colorScheme: darkDynamic ?? AppTheme.defaultDarkColorScheme,
            ),
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
