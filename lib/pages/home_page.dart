import 'package:flutter/material.dart';
import 'package:super_task_list/components/add_task_button.dart';
import 'package:super_task_list/components/custom_progress_indicator.dart';
import 'package:super_task_list/components/sign_out_button.dart';
import 'package:super_task_list/components/task_list_view.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/task_model.dart';
import 'package:super_task_list/pages/base_page.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  List<TaskModel>? _tasks;

  Future<void> _updateTasks() async {
    final taskList = await DBOperations.getTasks();
    setState(() {
      _tasks = taskList;
    });
  }

  Future<void> _addTask(
    BuildContext context,
    TextEditingController controller,
  ) async {
    await DBOperations.createTask(controller.text);
    await _updateTasks();
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _updateTasks();
  }

  @override
  Widget build(BuildContext context) {
    final areTasksNull = (_tasks == null);
    return BasePage(
      title: 'Suas Tarefas',
      leading: const SignOutButton(),
      floatingActionButton: AddTaskButton(notifyParent: _addTask),
      child: areTasksNull
          ? const CustomProgressIndicator()
          : TaskListView(
              tasks: _tasks!,
              notifyParent: _updateTasks,
            ),
    );
  }
}
