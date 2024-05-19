import 'package:flutter/material.dart';
import 'package:super_task_list/models/task_model.dart';

class TaskWidget extends InheritedWidget {
  final List<TaskModel> tasks;
  final Future<void> Function() downloadTasks;
  final Future<void> Function(
    BuildContext context,
    TextEditingController controller,
  ) addTask;

  const TaskWidget({
    super.key,
    required super.child,
    required this.tasks,
    required this.downloadTasks,
    required this.addTask,
  });

  static TaskWidget of(BuildContext context) {
    final TaskWidget? result;
    result = context.dependOnInheritedWidgetOfExactType<TaskWidget>();
    print('-- passei por aqui --');
    assert(result != null, 'No TaskWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskWidget oldWidget) {
    return tasks != oldWidget.tasks;
  }
}
