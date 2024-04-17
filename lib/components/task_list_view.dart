import 'package:flutter/material.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/task_model.dart';

class TaskListView extends StatefulWidget {
  final List<TaskModel> tasks;
  final Function() notifyParent;

  const TaskListView(
      {super.key, required this.tasks, required this.notifyParent});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    if (widget.tasks.isEmpty) {
      return const Center(
        child: Text('Você não possui nenhuma tarefa'),
      );
    }
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
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
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Editar Tarefa',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final db = DBOperations();
                            await db.updateTask(
                              widget.tasks[index].id,
                              titleController.text,
                            );
                            widget.notifyParent();
                            if (!context.mounted) return;
                            Navigator.pop(context);
                          },
                          child: const Text('Salvar'),
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
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
