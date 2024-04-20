import 'package:flutter/material.dart';
import 'package:super_task_list/components/email_form_field.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/pages/base_page.dart';

final class ForgotPasswordPage extends StatelessWidget {
  final _emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  Future<void> _tryRecoverPassword(BuildContext context) async {
    String message = 'Um e-mail foi enviado para a recuperação da senha';
    try {
      await DBOperations.sendPasswordResetEmail(_emailController.text);
    } catch (error) {
      message = '$error';
    }
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Recuperar senha',
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Informe seu e-mail para recuperar a senha:'),
            const SizedBox(
              height: 12,
            ),
            EmailFormField(
              controller: _emailController,
              onFieldSubmitted: (value) async {
                await _tryRecoverPassword(context);
              },
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () async {
                await _tryRecoverPassword(context);
              },
              child: const Text('Recuperar'),
            ),
          ],
        ),
      ),
    );
  }
}
