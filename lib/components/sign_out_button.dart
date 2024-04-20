import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/utils/app_routes.dart';

final class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        DBOperations.signOut();
        context.go(AppRoutes.signInPage);
      },
      icon: const Icon(Icons.logout),
    );
  }
}
