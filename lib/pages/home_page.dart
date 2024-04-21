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
    final tasks = await DBOperations.getTasks();
    setState(() {
      _tasks = tasks;
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
      leading: const SignOutButton(),
      title: 'Suas Tarefas',
      actions: [
        IconButton(
          onPressed: () async {
            setState(() {
              _tasks = null;
            });
            await Future.delayed(Durations.extralong4);
            await _updateTasks();
          },
          icon: const Icon(Icons.restart_alt),
        )
      ],
      floatingActionButton: AddTaskButton(notifyParent: _addTask),
      child: StreamBuilder(
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
        stream: Stream.periodic(Durations.short4, (computationCount) => _tasks),
      ),
    );
  }
}
