import 'package:flutter/material.dart';
import 'package:super_task_list/components/forms/forgot_password_form.dart';
import 'package:super_task_list/components/misc/base_page.dart';

final class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Recuperar senha',
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ForgotPasswordForm(),
      ),
    );
  }
}
