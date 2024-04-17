import 'package:flutter/material.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/task_model.dart';

class TaskListView extends StatefulWidget {
  final List<TaskModel> tasks;

  const TaskListView({super.key, required this.tasks});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  late List<TaskModel> _tasks;

  Future<void> _updateTasks() async {
    final db = DBOperations();
    final taskList = await db.getTasks();
    setState(() {
      _tasks = taskList;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _tasks = widget.tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(_tasks[index].title),
      ),
    );
  }
}
