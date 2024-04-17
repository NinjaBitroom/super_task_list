import 'package:flutter/material.dart';
import 'package:super_task_list/models/task_model.dart';

class TaskListView extends StatefulWidget {
  final List<TaskModel> tasks;

  const TaskListView({super.key, required this.tasks});

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
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          title: Text(widget.tasks[index].title),
        ),
      ),
    );
  }
}
