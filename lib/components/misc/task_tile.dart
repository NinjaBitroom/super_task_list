import 'package:flutter/material.dart';
import 'package:super_task_list/components/dialogs/edit_task_dialog.dart';
import 'package:super_task_list/models/client_task_model.dart';

import '../../database/mem_operations.dart';

final class TaskTile extends StatefulWidget {
  final ClientTaskModel task;
  final int index;

  const TaskTile({
    super.key,
    required this.task,
    required this.index,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

final class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      key: Key(widget.task.clientId.toString()),
      secondary: IconButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) => EditTaskDialog(
              task: widget.task,
              index: widget.index,
            ),
          );
        },
        icon: const Icon(Icons.edit),
      ),
      title: Text(widget.task.title),
      value: widget.task.done,
      onChanged: (value) {
        setState(() {
          MemOperations.updateTask(
            widget.task.clientId,
            newDone: value,
          );
        });
      },
    );
  }
}
