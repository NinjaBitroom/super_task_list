import 'package:flutter/material.dart';
import 'package:super_task_list/components/task_tile.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/task_model.dart';

final class TaskListView extends StatefulWidget {
  final List<TaskModel> tasks;
  final Future<void> Function() updateTasks;

  const TaskListView(
      {super.key, required this.tasks, required this.updateTasks});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

final class _TaskListViewState extends State<TaskListView> {
  Future<void> _updateTask(
    BuildContext context,
    TextEditingController controller,
    int index,
  ) async {
    setState(() {
      widget.tasks[index].title = controller.text;
    });
    Navigator.pop(context);
    await DBOperations.updateTask(
      widget.tasks[index].id,
      newTitle: controller.text,
    );
    await widget.updateTasks();
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
                updateTasks: widget.updateTasks,
              ),
            ),
          );
  }
}
