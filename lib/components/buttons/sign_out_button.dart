import 'package:flutter/material.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/routes/sign_in_route.dart';

final class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        DBOperations.signOut();
        const SignInRoute().go(context);
      },
      icon: const Icon(Icons.logout),
    );
  }
}
