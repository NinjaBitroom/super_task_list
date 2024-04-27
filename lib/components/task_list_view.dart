import 'package:flutter/material.dart';
import 'package:super_task_list/components/task_tile.dart';
import 'package:super_task_list/models/task_model.dart';
import 'package:super_task_list/services/task_service.dart';

final class TaskListView extends StatefulWidget {
  final List<TaskModel> tasks;
  final Future<void> Function() loadTasks;

  const TaskListView({super.key, required this.tasks, required this.loadTasks});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

final class _TaskListViewState extends State<TaskListView> {
  Future<void> _updateTask(
    BuildContext context,
    TextEditingController controller,
    int index,
  ) async {
    Navigator.pop(context);
    await TaskService.updateTask(
      widget.tasks[index].id,
      newTitle: controller.text,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (widget.tasks.isEmpty)
        ? const Center(
            child: Text('Você não possui nenhuma tarefa'),
          )
        : ListView.builder(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 72),
            itemCount: widget.tasks.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TaskTile(
                task: widget.tasks[index],
                index: index,
                updateTask: _updateTask,
                updateTasks: widget.loadTasks,
              ),
            ),
          );
  }
}
