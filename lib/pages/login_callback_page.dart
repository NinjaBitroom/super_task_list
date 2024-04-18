import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/pages/base_page.dart';
import 'package:super_task_list/utils/app_routes.dart';

class LoginCallbackPage extends StatelessWidget {
  const LoginCallbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Recuperar Senha',
      leading: BackButton(
        onPressed: () async {
          final db = DBOperations();
          await db.signOut();
          if (!context.mounted) return;
          context.go(AppRoutes.signInPage);
        },
      ),
      child: const Placeholder(),
    );
  }
}
