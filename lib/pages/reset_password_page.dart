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
    try {
      await DBOperations.resetPassword(_newPasswordController.text);
      if (!context.mounted) return;
      context.go(AppRoutes.homePage);
    } catch (e, t) {
      debugPrint(t.toString());
      message = '$e';
    } finally {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Recuperar Senha',
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
