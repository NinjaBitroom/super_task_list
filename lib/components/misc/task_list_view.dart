import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/components/misc/custom_progress_indicator.dart';
import 'package:super_task_list/components/misc/task_tile.dart';
import 'package:super_task_list/providers/task_provider.dart';

final class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

final class _TaskListViewState extends State<TaskListView> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).download(notify: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const CustomProgressIndicator();
        } else if (value.tasks.isEmpty) {
          return const Center(
            child: Text('Você não possui nenhuma tarefa'),
          );
        } else {
          return ListView.builder(
            padding: MediaQuery.paddingOf(context).add(
              const EdgeInsets.fromLTRB(12, 12, 12, 86),
            ),
            itemCount: value.tasks.length,
            itemBuilder: (context, index) => TaskTile(
              task: value.tasks[index],
              index: index,
            ),
          );
        }
      },
    );
  }
}
