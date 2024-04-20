import 'package:flutter/material.dart';

class AddTaskDialog extends StatelessWidget {
  final Future<void> Function(
    BuildContext context,
    TextEditingController controller,
  ) notifyParent;
  const AddTaskDialog({super.key, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    return Dialog(
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
