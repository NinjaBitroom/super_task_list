import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/client_task_model.dart';
import 'package:super_task_list/providers/task_provider.dart';

class EditTaskDialog extends StatelessWidget {
  final ClientTaskModel task;

  const EditTaskDialog({
    super.key,
    required this.task,
  });

  Future<void> _editTask(BuildContext context, String value) async {
    final editedTask = task;
    editedTask.title = value;
    Provider.of<TaskProvider>(context, listen: false).update(editedTask);
    context.pop();
    if (editedTask.serverId != null) {
      await DBOperations.updateTask(editedTask.serverId!, newTitle: value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: task.title);
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(12),
      title: const Text('Editar tarefa'),
      children: [
        TextField(
          controller: titleController,
          autofocus: true,
          onSubmitted: (value) async {
            await _editTask(context, value);
          },
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Nome da tarefa',
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _editTask(context, titleController.text);
              },
              child: const Text('Salvar'),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.secondaryContainer,
                ),
                foregroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Deletar'),
            ),
          ],
        )
      ],
    );
  }
}
