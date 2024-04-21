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
  late Future<List<TaskModel>> _tasks;

  Future<void> _updateTasks() async {
    setState(() {
      _tasks = DBOperations.getTasks();
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
    return BasePage(
      title: 'Suas Tarefas',
      leading: const SignOutButton(),
      floatingActionButton: AddTaskButton(notifyParent: _addTask),
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TaskListView(
              tasks: snapshot.data!,
              notifyParent: _updateTasks,
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const CustomProgressIndicator();
        },
        future: _tasks,
      ),
    );
  }
}
