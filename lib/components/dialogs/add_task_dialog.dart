import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/client_task_model.dart';
import 'package:super_task_list/providers/task_provider.dart';
import 'package:uuid/uuid.dart';

final class AddTaskDialog extends StatelessWidget {
  final titleController = TextEditingController();

  AddTaskDialog({super.key});

  Future<void> _saveTask(BuildContext context, String value) async {
    final newClientTask = ClientTaskModel(
      clientId: const Uuid().v1(),
      createdAt: DateTime.now(),
      title: value,
      done: false,
    );
    DBOperations.createTask(value).then(
      (value) => newClientTask.serverId = value.id,
    );
    Provider.of<TaskProvider>(context, listen: false).add(newClientTask);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(12),
      title: const Text('Nova tarefa'),
      children: [
        TextField(
          controller: titleController,
          onSubmitted: (value) async {
            await _saveTask(context, value);
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
            await _saveTask(context, titleController.text);
          },
          child: const Text('Salvar'),
        )
      ],
    );
  }
}
