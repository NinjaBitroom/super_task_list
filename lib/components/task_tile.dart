import 'package:flutter/material.dart';
import 'package:super_task_list/components/edit_task_dialog.dart';
import 'package:super_task_list/models/task_model.dart';
import 'package:super_task_list/services/task_service.dart';

final class TaskTile extends StatefulWidget {
  final TaskModel task;
  final int index;
  final Future<void> Function(
    BuildContext context,
    TextEditingController controller,
    int index,
  ) updateTask;
  final Future<void> Function() updateTasks;

  const TaskTile(
      {super.key,
      required this.task,
      required this.index,
      required this.updateTask,
      required this.updateTasks});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

final class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      key: Key(widget.task.id.toString()),
      secondary: IconButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) => EditTaskDialog(
              task: widget.task,
              index: widget.index,
              updateTask: widget.updateTask,
              updateTasks: widget.updateTasks,
            ),
          );
        },
        icon: const Icon(Icons.edit),
      ),
      title: Text(widget.task.title),
      value: widget.task.done,
      onChanged: (value) async {
        await TaskService.updateTask(
          widget.task.id,
          newDone: value,
        );
      },
    );
  }
}
