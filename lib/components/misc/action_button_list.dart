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
    bool shouldShow = widget.scrollController.hasClients &&
        widget.scrollController.position.pixels > 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IgnorePointer(
          ignoring: !shouldShow,
          child: AnimatedOpacity(
            opacity: shouldShow ? 1 : 0,
            duration: Durations.medium1,
            child: ScrollUpButton(controller: widget.scrollController),
          ),
        ),
        const AddTaskButton(),
      ],
    );
  }
}
