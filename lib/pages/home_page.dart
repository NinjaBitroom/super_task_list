import 'package:flutter/material.dart';
import 'package:super_task_list/components/buttons/add_task_button.dart';
import 'package:super_task_list/components/buttons/sign_out_button.dart';
import 'package:super_task_list/components/misc/custom_progress_indicator.dart';
import 'package:super_task_list/components/misc/task_list_view.dart';
import 'package:super_task_list/components/misc/task_widget.dart';
import 'package:super_task_list/database/mem_operations.dart';
import 'package:super_task_list/pages/base_page.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      TaskWidget.of(context).downloadTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (MemOperations.tasks != null) {
      child = TaskListView(
        tasks: MemOperations.tasks!,
      );
    } else {
      child = const CustomProgressIndicator();
    }
    return BasePage(
      leading: const SignOutButton(),
      title: 'Suas Tarefas',
      actions: [
        IconButton(
          onPressed: () async {
            setState(() {
              MemOperations.tasks = null;
            });
            await Future.delayed(Durations.extralong4);
            if (!context.mounted) {
              return;
            }
            await TaskWidget.of(context).downloadTasks();
          },
          icon: const Icon(Icons.restart_alt),
        )
      ],
      floatingActionButton: const AddTaskButton(),
      child: child,
    );
  }
}
