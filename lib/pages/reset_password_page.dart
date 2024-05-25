import 'package:flutter/material.dart';
import 'package:super_task_list/components/forms/reset_password_form.dart';
import 'package:super_task_list/components/misc/base_page.dart';

final class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Recuperar Senha',
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ResetPasswordForm(),
      ),
    );
  }
}
