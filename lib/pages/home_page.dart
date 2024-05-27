import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/components/buttons/restart_button.dart';
import 'package:super_task_list/components/buttons/sign_out_button.dart';
import 'package:super_task_list/components/lists/floating_action_button_list.dart';
import 'package:super_task_list/components/lists/task_list_view.dart';
import 'package:super_task_list/components/misc/base_page.dart';
import 'package:super_task_list/components/misc/custom_progress_indicator.dart';
import 'package:super_task_list/providers/task_provider.dart';

final class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).download(notify: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) {
        Widget currentChild = child!;
        if (value.isLoading) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(0);
          }
          currentChild = const CustomProgressIndicator();
        } else if (value.tasks.isEmpty) {
          currentChild = const Center(
            child: Text('Você não possui nenhuma tarefa'),
          );
        }
        return BasePage(
          leading: const SignOutButton(),
          title: 'Suas Tarefas',
          actions: [
            Visibility(
              visible: !value.isLoading,
              child: const RestartButton().animate().fade(
                    curve: Easing.standard,
                    duration: Durations.medium1,
                  ),
            )
          ],
          floatingActionButton: Visibility(
            visible: !value.isLoading,
            maintainState: true,
            maintainAnimation: true,
            child: FloatingActionButtonList(
              scrollController: _scrollController,
            ),
          ),
          child: currentChild,
        );
      },
      child: TaskListView(
        controller: _scrollController,
      ).animate().fade(curve: Easing.standard, duration: Durations.long1),
    );
  }
}
