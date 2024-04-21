import 'package:flutter/material.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/task_model.dart';

class EditTaskDialog extends StatefulWidget {
  final TaskModel task;
  final int index;
  final Future<void> Function(
    BuildContext context,
    TextEditingController controller,
    int index,
  ) notifyGrandParent;
  final Future<void> Function() notifyGrandGrandParent;

  const EditTaskDialog(
      {super.key,
      required this.task,
      required this.index,
      required this.notifyGrandParent,
      required this.notifyGrandGrandParent});

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

final class _EditTaskDialogState extends State<EditTaskDialog> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.task.title);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              autofocus: true,
              onSubmitted: (value) async {
                await widget.notifyGrandParent(
                    context, titleController, widget.index);
              },
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Editar Tarefa',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await widget.notifyGrandParent(
                      context,
                      titleController,
                      widget.index,
                    );
                  },
                  child: const Text('Salvar'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  onPressed: () async {
                    await DBOperations.deleteTask(widget.task.id);
                    await widget.notifyGrandGrandParent();
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  },
                  child: const Text('Deletar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
