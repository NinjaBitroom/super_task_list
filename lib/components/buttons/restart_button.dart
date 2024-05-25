import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_task_list/providers/task_provider.dart';

final class RestartButton extends StatelessWidget {
  const RestartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await Provider.of<TaskProvider>(context, listen: false)
            .download(notify: true);
      },
      icon: const Icon(Icons.restart_alt),
    );
  }
}
