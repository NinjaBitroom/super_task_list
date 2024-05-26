import 'package:flutter/material.dart';
import 'package:super_task_list/components/buttons/restart_button.dart';
import 'package:super_task_list/components/buttons/sign_out_button.dart';
import 'package:super_task_list/components/lists/floating_action_button_list.dart';
import 'package:super_task_list/components/lists/task_list_view.dart';
import 'package:super_task_list/components/misc/base_page.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      leading: const SignOutButton(),
      title: 'Suas Tarefas',
      actions: const [
        RestartButton(),
      ],
      floatingActionButton:
          FloatingActionButtonList(scrollController: _scrollController),
      child: TaskListView(controller: _scrollController),
    );
  }
}
