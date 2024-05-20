import 'package:flutter/material.dart';
import 'package:super_task_list/components/misc/task_widget.dart';

final class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(12),
      title: const Text('Nova tarefa'),
      children: [
        TextField(
          controller: titleController,
          onSubmitted: (value) async {
            await TaskWidget.of(context).addTask(titleController.text);
          },
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Nome da tarefa',
          ),
          autofocus: true,
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () async {
            await TaskWidget.of(context).addTask(titleController.text);
          },
          child: const Text('Salvar'),
        )
      ],
    );
  }
}
