import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/components/dialogs/edit_task_dialog.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/client_task_model.dart';
import 'package:super_task_list/providers/task_provider.dart';

final class TaskTile extends StatefulWidget {
  final ClientTaskModel task;

  const TaskTile({
    super.key,
    required this.task,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

final class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: CheckboxListTile(
        key: Key(widget.task.clientId.toString()),
        secondary: IconButton(
          enableFeedback: true,
          tooltip: 'Editar tarefa',
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => EditTaskDialog(task: widget.task),
            );
          },
          icon: const Icon(Icons.edit),
        ),
        title: Text(widget.task.title),
        value: widget.task.done,
        onChanged: (value) async {
          final provider = Provider.of<TaskProvider>(context, listen: false);
          final task = provider.get(widget.task.clientId);
          task.done = value!;
          provider.update(task);
          if (task.serverId != null) {
            await DBOperations.updateTask(
              task.serverId!,
              newDone: value,
            );
          }
        },
      ),
    );
  }
}
