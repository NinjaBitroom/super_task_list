import 'package:flutter/material.dart';
import 'package:super_task_list/components/fields/email_form_field.dart';
import 'package:super_task_list/database/db_operations.dart';

final class ForgotPasswordForm extends StatelessWidget {
  final _emailController = TextEditingController();

  ForgotPasswordForm({super.key});

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
    return Form(
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
            textInputAction: TextInputAction.send,
          ),
          const SizedBox(
            height: 12,
          ),
          FilledButton(
            onPressed: () async {
              await _tryRecoverPassword(context);
            },
            child: const Text('Recuperar'),
          ),
        ],
      ),
    );
  }
}
