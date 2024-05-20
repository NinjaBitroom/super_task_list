import 'package:flutter/material.dart';
import 'package:super_task_list/components/buttons/add_task_button.dart';
import 'package:super_task_list/components/buttons/sign_out_button.dart';
import 'package:super_task_list/components/misc/custom_progress_indicator.dart';
import 'package:super_task_list/components/misc/task_list_view.dart';
import 'package:super_task_list/components/misc/task_widget.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/database/mem_operations.dart';
import 'package:super_task_list/pages/base_page.dart';
import 'package:uuid/uuid.dart';

import '../models/client_task_model.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  Future<void> _downloadTasks() async {
    setState(() {
      MemOperations.tasks = null;
    });
    final tasks = await DBOperations.getTasks();
    setState(() {
      for (var task in tasks) {
        ClientTaskModel newTask = ClientTaskModel(
          clientId: const Uuid().v1(),
          createdAt: DateTime.now(),
          done: false,
          title: task.title,
          serverId: task.id,
        );
        MemOperations.tasks ??= [];
        MemOperations.tasks?.add(newTask);
      }
      MemOperations.sortTasks();
    });
  }

  Future<void> _addTask(String title) async {
    setState(() {
      ClientTaskModel newClientTask = MemOperations.createTask(title);
      DBOperations.createTask(title).then(
        (value) {
          setState(() {
            newClientTask.serverId = value.id;
            MemOperations.sortTasks();
          });
        },
      );
    });
  }

  Future<void> _updateTask(
    String id, {
    String? newTitle,
    bool? newDone,
    int? newServerId,
  }) async {
    MemOperations.updateTask(
      id,
      newTitle: newTitle,
      newDone: newDone,
      newServerId: newServerId,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _downloadTasks();
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
    return TaskWidget(
      tasks: MemOperations.tasks,
      downloadTasks: _downloadTasks,
      addTask: _addTask,
      updateTask: _updateTask,
      child: BasePage(
        leading: const SignOutButton(),
        title: 'Suas Tarefas',
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                MemOperations.tasks = null;
              });
              await Future.delayed(Durations.extralong4);
              await _downloadTasks();
            },
            icon: const Icon(Icons.restart_alt),
          )
        ],
        floatingActionButton: const AddTaskButton(),
        child: child,
      ),
    );
  }
}
