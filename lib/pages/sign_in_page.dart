import 'package:flutter/material.dart';
import 'package:super_task_list/components/forms/sign_in_form.dart';
import 'package:super_task_list/components/misc/base_page.dart';

final class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Login',
      automaticallyImplyLeading: false,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SignInForm(),
      ),
    );
  }
}
