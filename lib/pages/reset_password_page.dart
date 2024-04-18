import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/components/password_form_field.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/pages/base_page.dart';
import 'package:super_task_list/utils/app_routes.dart';

final class ResetPasswordPage extends StatelessWidget {
  final _newPasswordController = TextEditingController();

  ResetPasswordPage({super.key});

  Future<void> _tryResetPassword(BuildContext context) async {
    String message = 'A senha foi alterada com sucesso';
    final db = DBOperations();
    try {
      await db.resetPassword(_newPasswordController.text);
    } catch (error) {
      message = '$error';
    }
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    context.go(AppRoutes.homePage);
  }

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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PasswordFormField(
              autofillHints: const [AutofillHints.newPassword],
              controller: _newPasswordController,
              labelText: 'Nova Senha',
              onFieldSubmitted: (value) async {
                await _tryResetPassword(context);
              },
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () async {
                await _tryResetPassword(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
