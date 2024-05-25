import 'package:flutter/material.dart';
import 'package:super_task_list/components/buttons/add_task_button.dart';
import 'package:super_task_list/components/buttons/scroll_up_button.dart';

class ActionButtonList extends StatefulWidget {
  final ScrollController controller;

  const ActionButtonList({super.key, required this.controller});

  @override
  State<ActionButtonList> createState() => _ActionButtonListState();
}

class _ActionButtonListState extends State<ActionButtonList> {
  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(() {
      setState(() {});
    });
    if (!widget.controller.hasClients) {
      return const AddTaskButton();
    }
    return widget.controller.position.pixels == 0
        ? const AddTaskButton()
        : Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScrollUpButton(controller: widget.controller),
              const AddTaskButton(),
            ],
          );
  }
}
