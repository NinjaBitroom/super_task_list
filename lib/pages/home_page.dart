import 'package:flutter/material.dart';
import 'package:super_task_list/components/buttons/add_task_button.dart';
import 'package:super_task_list/components/buttons/restart_button.dart';
import 'package:super_task_list/components/buttons/sign_out_button.dart';
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
      floatingActionButton: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.small(
                onPressed: () {
                  _homeController.animateTo(
                    0,
                    duration: Durations.medium2,
                    curve: Curves.bounceInOut,
                  );
                },
                child: const Icon(Icons.arrow_upward),
              ),
            ),
            const AddTaskButton(),
          ],
        ),
      ),
      child: TaskListView(controller: _homeController),
    );
  }
}
