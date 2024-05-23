import 'package:flutter/material.dart';
import 'package:super_task_list/components/dialogs/add_task_dialog.dart';

final class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AddTaskDialog(),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
