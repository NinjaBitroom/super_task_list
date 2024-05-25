import 'package:flutter/material.dart';
import 'package:super_task_list/components/fields/password_form_field.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/routes/home_route.dart';

class ResetPasswordForm extends StatelessWidget {
  final _newPasswordController = TextEditingController();

  ResetPasswordForm({super.key});

  Future<void> _tryResetPassword(BuildContext context) async {
    String message = 'A senha foi alterada com sucesso';
    try {
      await DBOperations.resetPassword(_newPasswordController.text);
      if (!context.mounted) return;
      const HomeRoute().go(context);
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
    return Form(
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
          FilledButton(
            onPressed: () async {
              await _tryResetPassword(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
