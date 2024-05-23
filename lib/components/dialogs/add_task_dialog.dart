import 'package:flutter/material.dart';

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
          onSubmitted: (value) async {},
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Nome da tarefa',
          ),
          autofocus: true,
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () async {},
          child: const Text('Salvar'),
        )
      ],
    );
  }
}
