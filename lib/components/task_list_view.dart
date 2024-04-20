import 'package:flutter/material.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/task_model.dart';

class TaskListView extends StatefulWidget {
  final List<TaskModel> tasks;
  final Future<void> Function() notifyParent;

  const TaskListView(
      {super.key, required this.tasks, required this.notifyParent});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  Future<void> _updateTask(
    BuildContext context,
    TextEditingController controller,
    int index,
  ) async {
    final db = DBOperations();
    await db.updateTask(
      widget.tasks[index].id,
      newTitle: controller.text,
    );
    await widget.notifyParent();
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tasks.isEmpty) {
      return const Center(
        child: Text('Você não possui nenhuma tarefa'),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 72),
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: IconButton(
            onPressed: () async {
              final titleController = TextEditingController(
                text: widget.tasks[index].title,
              );
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextField(
                          controller: titleController,
                          autofocus: true,
                          onSubmitted: (value) async {
                            await _updateTask(context, titleController, index);
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Editar Tarefa',
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await _updateTask(
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
                                  Theme.of(context).colorScheme.errorContainer,
                                ),
                                foregroundColor: MaterialStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer,
                                ),
                              ),
                              onPressed: () async {
                                final db = DBOperations();
                                await db.deleteTask(widget.tasks[index].id);
                                await widget.notifyParent();
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
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
          title: Text(widget.tasks[index].title),
          trailing: Checkbox(
            value: widget.tasks[index].done,
            onChanged: (value) async {
              final db = DBOperations();
              await db.updateTask(widget.tasks[index].id, newDone: value);
              await widget.notifyParent();
            },
          ),
        ),
      ),
    );
  }
}
