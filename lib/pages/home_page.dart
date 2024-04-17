import 'package:flutter/material.dart';
import 'package:super_task_list/app_routes.dart';
import 'package:super_task_list/components/custom_progress_indicator.dart';
import 'package:super_task_list/components/task_list_view.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/task_model.dart';
import 'package:super_task_list/pages/base_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TaskModel>? _tasks;

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
    _updateTasks();
  }

  @override
  Widget build(BuildContext context) {
    final Widget body;
    if (_tasks != null) {
      body = TaskListView(
        tasks: _tasks!,
        notifyParent: _updateTasks,
      );
    } else {
      body = const CustomProgressIndicator();
    }
    return BasePage(
      title: 'Suas Tarefas',
      leading: IconButton(
        onPressed: () {
          final db = DBOperations();
          db.signOut();
          Navigator.pushReplacementNamed(context, AppRoutes.signInPage);
        },
        icon: const Icon(Icons.logout),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final titleController = TextEditingController();
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
                        labelText: 'Nome da tarefa',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final db = DBOperations();
                        await db.createTask(titleController.text);
                        await _updateTasks();
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
        child: const Icon(Icons.add),
      ),
      child: body,
    );
  }
}
