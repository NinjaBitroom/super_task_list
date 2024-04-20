import 'package:flutter/material.dart';
import 'package:super_task_list/components/edit_task_dialog.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/task_model.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final int index;
  final Future<void> Function(
    BuildContext context,
    TextEditingController controller,
    int index,
  ) notifyParent;
  final Future<void> Function() notifyGrandParent;

  const TaskTile(
      {super.key,
      required this.task,
      required this.index,
      required this.notifyParent,
      required this.notifyGrandParent});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      secondary: IconButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) => EditTaskDialog(
              task: task,
              index: index,
              notifyGrandParent: notifyParent,
              notifyGrandGrandParent: notifyGrandParent,
            ),
          );
        },
        icon: const Icon(Icons.edit),
      ),
      title: Text(task.title),
      value: task.done,
      onChanged: (value) async {
        await DBOperations.updateTask(
          task.id,
          newDone: value,
        );
        await notifyGrandParent();
      },
    );
  }
}
