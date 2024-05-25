import 'package:flutter/material.dart';
import 'package:super_task_list/components/forms/sign_up_form.dart';
import 'package:super_task_list/components/misc/base_page.dart';

final class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Criar Conta',
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SignUpForm(),
      ),
    );
  }
}
