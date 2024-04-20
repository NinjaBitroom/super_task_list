import 'package:flutter/material.dart';
import 'package:super_task_list/components/add_task_dialog.dart';

final class AddTaskButton extends StatelessWidget {
  final Future<void> Function(
    BuildContext context,
    TextEditingController controller,
  ) notifyParent;

  const AddTaskButton({super.key, required this.notifyParent});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AddTaskDialog(notifyParent: notifyParent),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
