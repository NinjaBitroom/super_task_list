import 'package:flutter/material.dart';
import 'package:super_task_list/components/misc/task_tile.dart';
import 'package:super_task_list/models/client_task_model.dart';

final class TaskListView extends StatefulWidget {
  final List<ClientTaskModel> tasks;

  const TaskListView({super.key, required this.tasks});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

final class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    if ((widget.tasks.isEmpty)) {
      return const Center(
        child: Text('Você não possui nenhuma tarefa'),
      );
    } else {
      return ListView.builder(
        padding: MediaQuery.paddingOf(context)
            .add(const EdgeInsets.fromLTRB(12, 12, 12, 72)),
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TaskTile(
            task: widget.tasks[index],
            index: index,
          ),
        ),
      );
    }
  }
}
