import 'package:flutter/material.dart';
import 'package:super_task_list/pages/base_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Recuperar'),
            ),
          ],
        ),
      ),
    );
  }
}
