import 'package:flutter/material.dart';
import 'package:super_task_list/components/misc/task_widget.dart';
import 'package:super_task_list/database/mem_operations.dart';
import 'package:super_task_list/models/client_task_model.dart';

class EditTaskDialog extends StatefulWidget {
  final ClientTaskModel task;
  final int index;

  const EditTaskDialog({
    super.key,
    required this.task,
    required this.index,
  });

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

final class _EditTaskDialogState extends State<EditTaskDialog> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.task.title);
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(12),
      title: const Text('Editar tarefa'),
      children: [
        TextField(
          controller: titleController,
          autofocus: true,
          onSubmitted: (value) async {
            await TaskWidget.of(context).updateTask(
              widget.task.clientId,
              newTitle: titleController.text,
            );
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
                await TaskWidget.of(context).updateTask(
                  widget.task.clientId,
                  newTitle: titleController.text,
                );
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
              onPressed: () async {
                MemOperations.deleteTask(widget.task.clientId);
                await TaskWidget.of(context).downloadTasks();
                if (!context.mounted) return;
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
