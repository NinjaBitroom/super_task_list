import 'package:flutter/material.dart';
import 'package:super_task_list/components/dialogs/edit_task_dialog.dart';
import 'package:super_task_list/models/client_task_model.dart';

class EditButton extends StatelessWidget {
  final ClientTaskModel task;

  const EditButton({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      enableFeedback: true,
      tooltip: 'Editar tarefa',
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => EditTaskDialog(task: task),
        );
      },
      icon: const Icon(Icons.edit),
    );
  }
}
