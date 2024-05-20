import 'package:flutter/material.dart';
import 'package:super_task_list/app.dart';
import 'package:super_task_list/components/misc/task_widget.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/database/mem_operations.dart';
import 'package:super_task_list/models/client_task_model.dart';
import 'package:uuid/uuid.dart';

class AppWithProviders extends StatefulWidget {
  const AppWithProviders({super.key});

  @override
  State<AppWithProviders> createState() => _AppWithProvidersState();
}

class _AppWithProvidersState extends State<AppWithProviders> {
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

  Future<void> _deleteTask(String id) async {
    setState(() {
      final serverId = MemOperations.deleteTask(id);
      MemOperations.tasks = MemOperations.tasks;
      DBOperations.deleteTask(serverId!);
    });
  }

  void _forceUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TaskWidget(
      downloadTasks: _downloadTasks,
      updateTask: _updateTask,
      addTask: _addTask,
      deleteTask: _deleteTask,
      forceUpdate: _forceUpdate,
      tasks: MemOperations.tasks,
      child: const App(),
    );
  }
}
