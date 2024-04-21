import 'package:flutter/material.dart';
import 'package:super_task_list/components/edit_task_dialog.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/task_model.dart';

final class TaskTile extends StatefulWidget {
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
  State<TaskTile> createState() => _TaskTileState();
}

final class _TaskTileState extends State<TaskTile> {
  bool _enabled = true;

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
              notifyGrandParent: widget.notifyParent,
              notifyGrandGrandParent: widget.notifyGrandParent,
            ),
          );
        },
        icon: const Icon(Icons.edit),
      ),
      title: Text(widget.task.title),
      value: widget.task.done,
      enabled: _enabled,
      onChanged: (value) async {
        setState(() {
          _enabled = false;
        });
        await DBOperations.updateTask(
          widget.task.id,
          newDone: value,
        );
        await widget.notifyGrandParent();
        setState(() {
          _enabled = true;
        });
      },
    );
  }
}
