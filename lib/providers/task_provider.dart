import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/client_task_model.dart';
import 'package:uuid/uuid.dart';

final class TaskProvider extends ChangeNotifier {
  final List<ClientTaskModel> _tasks = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  UnmodifiableListView<ClientTaskModel> get tasks {
    final taskListCopy = List<ClientTaskModel>.from(_tasks);
    taskListCopy.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return UnmodifiableListView(taskListCopy);
  }

  UnmodifiableListView<ClientTaskModel> get incompleteTasks {
    final taskListCopy = List<ClientTaskModel>.from(_tasks);
    taskListCopy.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return UnmodifiableListView(
      taskListCopy.where((element) => !element.done),
    );
  }

  UnmodifiableListView<ClientTaskModel> get completedTasks {
    final taskListCopy = List<ClientTaskModel>.from(_tasks);
    taskListCopy.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return UnmodifiableListView(
      taskListCopy.where((element) => element.done),
    );
  }

  void add(ClientTaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  ClientTaskModel get(String id) {
    return _tasks.firstWhere((element) => element.clientId == id);
  }

  void update(ClientTaskModel task) {
    final index =
        _tasks.indexWhere((element) => element.clientId == task.clientId);
    _tasks[index] = task;
    notifyListeners();
  }

  void remove(ClientTaskModel task) {
    _tasks.removeWhere((element) => element.clientId == task.clientId);
    notifyListeners();
  }

  Future<void> download({required bool notify}) async {
    _isLoading = true;
    _tasks.clear();
    if (notify) {
      notifyListeners();
    }
    await Future.delayed(const Duration(seconds: 1));
    final downloadedTasks = await DBOperations.getTasks();
    for (var task in downloadedTasks) {
      add(ClientTaskModel(
        clientId: const Uuid().v1(),
        serverId: task.id,
        createdAt: task.createdAt,
        title: task.title,
        done: task.done,
      ));
    }
    _isLoading = false;
    if (notify) {
      notifyListeners();
    }
  }
}
