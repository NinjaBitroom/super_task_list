import 'package:flutter/material.dart';
import 'package:super_task_list/components/add_task_button.dart';
import 'package:super_task_list/components/custom_progress_indicator.dart';
import 'package:super_task_list/components/sign_out_button.dart';
import 'package:super_task_list/components/task_list_view.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/pages/base_page.dart';
import 'package:super_task_list/services/task_service.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  Future<void> _loadTasks() async {
    final tasks = await DBOperations.getTasks();
    setState(() {
      TaskService.tasks = tasks;
      TaskService.tasks?.sort(
        (a, b) => a.id.compareTo(b.id),
      );
    });
  }

  Future<void> _addTask(
    BuildContext context,
    TextEditingController controller,
  ) async {
    Navigator.pop(context);
    await TaskService.createTask(controller.text);
    // await _loadTasks();
    // if (!context.mounted) return;
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      leading: const SignOutButton(),
      title: 'Suas Tarefas',
      actions: [
        IconButton(
          onPressed: () async {
            setState(() {
              TaskService.tasks = null;
            });
            await Future.delayed(Durations.extralong4);
            await _loadTasks();
          },
          icon: const Icon(Icons.restart_alt),
        )
      ],
      floatingActionButton: AddTaskButton(addTask: _addTask),
      child: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TaskListView(
              tasks: snapshot.data!,
              loadTasks: _loadTasks,
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const CustomProgressIndicator();
        },
        stream: Stream.periodic(
            Durations.short1, (computationCount) => TaskService.tasks),
      ),
    );
  }
}
