import 'package:flutter/material.dart';

final class AddTaskDialog extends StatelessWidget {
  final Future<void> Function(
    BuildContext context,
    TextEditingController controller,
  ) notifyParent;

  const AddTaskDialog({super.key, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (value) async {
                await notifyParent(context, titleController);
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
                await notifyParent(context, titleController);
              },
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}
