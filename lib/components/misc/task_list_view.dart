import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/components/misc/custom_progress_indicator.dart';
import 'package:super_task_list/components/misc/task_tile.dart';
import 'package:super_task_list/models/client_task_model.dart';
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

  int _selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    final filters = [
      ChoiceChip(
        showCheckmark: false,
        label: const Text('Todas'),
        selected: _selectedFilter == 0,
        avatar: const Icon(Icons.list),
        onSelected: (value) {
          setState(() {
            _selectedFilter = 0;
          });
        },
      ),
      ChoiceChip(
        showCheckmark: false,
        label: const Text('Em andamento'),
        selected: _selectedFilter == 1,
        onSelected: (value) {
          setState(() {
            _selectedFilter = 1;
          });
        },
      ),
      ChoiceChip(
        showCheckmark: false,
        label: const Text('Concluídas'),
        selected: _selectedFilter == 2,
        avatar: const Icon(Icons.done_all),
        onSelected: (value) {
          setState(() {
            _selectedFilter = 2;
          });
        },
      ),
    ];

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
          switch (_selectedFilter) {
            case 1:
              tasks = value.incompleteTasks;
              break;
            case 2:
              tasks = value.completedTasks;
              break;
          }
          return ListView.builder(
            padding: MediaQuery.paddingOf(context).add(
              const EdgeInsets.fromLTRB(12, 12, 12, 86),
            ),
            itemCount: tasks.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return SizedBox(
                  height: 48,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: filters[index],
                      );
                    },
                    itemCount: filters.length,
                  ),
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
