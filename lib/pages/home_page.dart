import 'package:flutter/material.dart';
import 'package:super_task_list/components/buttons/restart_button.dart';
import 'package:super_task_list/components/buttons/sign_out_button.dart';
import 'package:super_task_list/components/misc/action_button_list.dart';
import 'package:super_task_list/components/misc/base_page.dart';
import 'package:super_task_list/components/misc/task_list_view.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  final _homeController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      leading: const SignOutButton(),
      title: 'Suas Tarefas',
      actions: const [
        RestartButton(),
      ],
      floatingActionButton: ActionButtonList(controller: _homeController),
      child: TaskListView(controller: _homeController),
    );
  }
}
