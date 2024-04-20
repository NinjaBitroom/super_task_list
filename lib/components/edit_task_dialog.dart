import 'package:flutter/material.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/task_model.dart';

class EditTaskDialog extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: task.title);
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
                await notifyGrandParent(context, titleController, index);
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
                    await notifyGrandParent(
                      context,
                      titleController,
                      index,
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
                    await DBOperations.deleteTask(task.id);
                    await notifyGrandGrandParent();
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
