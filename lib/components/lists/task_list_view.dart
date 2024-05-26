import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/components/lists/choice_chip_list.dart';
import 'package:super_task_list/components/misc/custom_progress_indicator.dart';
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
          UnmodifiableListView<ClientTaskModel> tasks = value.tasks;
          switch (_selectedChoice) {
            case 1:
              tasks = value.incompleteTasks;
              break;
            case 2:
              tasks = value.completedTasks;
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
      },
    );
  }
}
