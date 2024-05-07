import 'package:flutter/material.dart';
import 'package:super_task_list/models/task_model.dart';
import 'package:super_task_list/services/task_service.dart';

class EditTaskDialog extends StatefulWidget {
  final TaskModel task;
  final int index;
  final Future<void> Function(
    BuildContext context,
    TextEditingController controller,
    int index,
  ) updateTask;
  final Future<void> Function() loadTasks;

  const EditTaskDialog(
      {super.key,
      required this.task,
      required this.index,
      required this.updateTask,
      required this.loadTasks});

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
            await widget.updateTask(
              context,
              titleController,
              widget.index,
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
                await widget.updateTask(
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
                Navigator.pop(context);
                await TaskService.deleteTask(widget.task.id);
                widget.loadTasks();
              },
              child: const Text('Deletar'),
            ),
          ],
        )
      ],
    );
  }
}
