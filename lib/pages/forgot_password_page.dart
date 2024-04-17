import 'package:flutter/material.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/pages/base_page.dart';

final class ForgotPasswordPage extends StatelessWidget {
  final _emailController = TextEditingController();

  ForgotPasswordPage({super.key});

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
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                final db = DBOperations();
                db.recoverPassword(_emailController.text);
              },
              child: const Text('Recuperar'),
            ),
          ],
        ),
      ),
    );
  }
}
