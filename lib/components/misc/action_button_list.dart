import 'package:flutter/material.dart';
import 'package:super_task_list/components/buttons/add_task_button.dart';
import 'package:super_task_list/components/buttons/scroll_up_button.dart';

class ActionButtonList extends StatefulWidget {
  final ScrollController scrollController;

  const ActionButtonList({super.key, required this.scrollController});

  @override
  State<ActionButtonList> createState() => _ActionButtonListState();
}

class _ActionButtonListState extends State<ActionButtonList> {
  @override
  Widget build(BuildContext context) {
    widget.scrollController.addListener(() {
      setState(() {});
    });
    if (!widget.scrollController.hasClients) {
      return const AddTaskButton();
    }
    if (widget.scrollController.position.pixels == 0) {
      return const AddTaskButton();
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScrollUpButton(controller: widget.scrollController),
          const AddTaskButton(),
        ],
      );
    }
  }
}
