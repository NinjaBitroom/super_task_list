import 'package:flutter/material.dart';

final class AddTaskDialog extends StatelessWidget {
  final Future<void> Function(
    BuildContext context,
    TextEditingController controller,
  ) addTask;

  const AddTaskDialog({super.key, required this.addTask});

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
            await addTask(context, titleController);
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
            await addTask(context, titleController);
          },
          child: const Text('Salvar'),
        )
      ],
    );
  }
}
