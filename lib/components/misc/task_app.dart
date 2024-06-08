import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/providers/task_provider.dart';
import 'package:super_task_list/utils/app_router.dart';

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
            theme: lightDynamic != null
                ? ThemeData.from(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: lightDynamic.primary,
                      brightness: lightDynamic.brightness,
                    ),
                    useMaterial3: true,
                  )
                : ThemeData.light(useMaterial3: true),
            darkTheme: darkDynamic != null
                ? ThemeData.from(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: darkDynamic.primary,
                      brightness: darkDynamic.brightness,
                    ),
                    useMaterial3: true,
                  )
                : ThemeData.dark(useMaterial3: true),
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
