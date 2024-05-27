import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/components/lists/choice_chip_list.dart';
import 'package:super_task_list/components/misc/task_tile.dart';
import 'package:super_task_list/models/client_task_model.dart';
import 'package:super_task_list/providers/task_provider.dart';

final class TaskListView extends StatefulWidget {
  final ScrollController controller;

  const TaskListView({super.key, required this.controller});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

final class _TaskListViewState extends State<TaskListView> {
  int _selectedChoice = 0;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    UnmodifiableListView<ClientTaskModel> tasks = provider.tasks;
    switch (_selectedChoice) {
      case 1:
        tasks = provider.incompleteTasks;
        break;
      case 2:
        tasks = provider.completedTasks;
        break;
    }
    return ListView.builder(
      controller: widget.controller,
      padding: MediaQuery.paddingOf(context).add(
        const EdgeInsets.fromLTRB(12, 12, 12, 80),
      ),
      itemCount: tasks.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return ChoiceChipList(
            selectedChoice: _selectedChoice,
            onSelected: (value) {
              setState(() {
                _selectedChoice = value;
              });
            },
          );
        }
        return TaskTile(task: tasks[index - 1]);
      },
    );
  }
}
