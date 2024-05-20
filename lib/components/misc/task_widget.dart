import 'package:flutter/material.dart';
import 'package:super_task_list/models/client_task_model.dart';

class TaskWidget extends InheritedWidget {
  final List<ClientTaskModel>? tasks;
  final Future<void> Function() downloadTasks;
  final Future<void> Function(String title) addTask;
  final Future<void> Function(String id,
      {String? newTitle, bool? newDone, int? newServerId}) updateTask;

  const TaskWidget({
    super.key,
    required super.child,
    required this.tasks,
    required this.downloadTasks,
    required this.addTask,
    required this.updateTask,
  });

  static TaskWidget? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskWidget>();
  }

  static TaskWidget of(BuildContext context) {
    final result = maybeOf(context);
    if (result == null) {
      throw 'No TaskWidget found in context';
    }
    return result;
  }

  @override
  bool updateShouldNotify(TaskWidget oldWidget) {
    return tasks != oldWidget.tasks;
  }
}
