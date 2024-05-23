import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/components/buttons/add_task_button.dart';
import 'package:super_task_list/components/buttons/restart_button.dart';
import 'package:super_task_list/components/buttons/sign_out_button.dart';
import 'package:super_task_list/components/misc/task_list_view.dart';
import 'package:super_task_list/models/task_list_model.dart';
import 'package:super_task_list/pages/base_page.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      leading: const SignOutButton(),
      title: 'Suas Tarefas',
      actions: [
        RestartButton(
          onPressed: () async {
            await Provider.of<TaskListModel>(context, listen: false)
                .download(notify: true);
          },
        ),
      ],
      floatingActionButton: const AddTaskButton(),
      child: const TaskListView(),
    );
  }
}
