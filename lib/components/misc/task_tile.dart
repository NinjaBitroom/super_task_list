import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/components/buttons/edit_button.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/client_task_model.dart';
import 'package:super_task_list/providers/task_provider.dart';

class TaskTile extends StatelessWidget {
  final ClientTaskModel task;

  const TaskTile({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: CheckboxListTile(
        key: Key(task.clientId.toString()),
        secondary: EditButton(task: task),
        title: Text(task.title),
        value: task.done,
        onChanged: (value) async {
          final provider = Provider.of<TaskProvider>(context, listen: false);
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
