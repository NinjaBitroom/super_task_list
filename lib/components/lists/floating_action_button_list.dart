import 'package:flutter/material.dart';
import 'package:super_task_list/components/buttons/add_task_button.dart';
import 'package:super_task_list/components/buttons/scroll_up_button.dart';

class FloatingActionButtonList extends StatefulWidget {
  final ScrollController scrollController;

  const FloatingActionButtonList({super.key, required this.scrollController});

  @override
  State<FloatingActionButtonList> createState() =>
      _FloatingActionButtonListState();
}

class _FloatingActionButtonListState extends State<FloatingActionButtonList> {
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
        ScrollUpButton(
          controller: widget.scrollController,
          visible: shouldShow,
        ),
        const AddTaskButton(),
      ],
    );
  }
}
