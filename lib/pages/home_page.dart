import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/components/custom_progress_indicator.dart';
import 'package:super_task_list/components/task_list_view.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/models/task_model.dart';
import 'package:super_task_list/pages/base_page.dart';
import 'package:super_task_list/utils/app_routes.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  List<TaskModel>? _tasks;

  Future<void> _updateTasks() async {
    final taskList = await DBOperations.getTasks();
    setState(() {
      _tasks = taskList;
    });
  }

  Future<void> _addTask(
    BuildContext context,
    TextEditingController controller,
  ) async {
    await DBOperations.createTask(controller.text);
    await _updateTasks();
    if (!context.mounted) return;
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _updateTasks();
  }

  @override
  Widget build(BuildContext context) {
    final areTasksNull = (_tasks == null);
    return BasePage(
      title: 'Suas Tarefas',
      leading: IconButton(
        onPressed: () {
          DBOperations.signOut();
          context.go(AppRoutes.signInPage);
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
                      onSubmitted: (value) async {
                        await _addTask(context, titleController);
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Nome da tarefa',
                      ),
                      autofocus: true,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _addTask(context, titleController);
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
      child: areTasksNull
          ? const CustomProgressIndicator()
          : TaskListView(
              tasks: _tasks!,
              notifyParent: _updateTasks,
            ),
    );
  }
}
