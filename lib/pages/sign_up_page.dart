import 'package:flutter/material.dart';
import 'package:super_task_list/components/fields/email_form_field.dart';
import 'package:super_task_list/components/fields/password_form_field.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/pages/base_page.dart';
import 'package:super_task_list/routes/home_route.dart';

final class SignUpPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  SignUpPage({super.key});

  void _trySignUp(BuildContext context) {
    final signUp = DBOperations.signUp(
      _emailController.text,
      _passwordController.text,
    );
    signUp.then((value) {
      if ((value.session == null) && (value.user == null)) {
        throw Exception('Erro ao criar conta!');
      }
      const HomeRoute().go(context);
    }).onError((error, stackTrace) {
      debugPrint('$stackTrace');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$error'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Criar Conta',
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EmailFormField(
              controller: _emailController,
              onFieldSubmitted: (value) {
                _passwordFocusNode.requestFocus();
              },
            ),
            const SizedBox(
              height: 12,
            ),
            PasswordFormField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              autofillHints: const [AutofillHints.newPassword],
              onFieldSubmitted: (value) {
                _trySignUp(context);
              },
            ),
            const SizedBox(
              height: 12,
            ),
            FilledButton(
              child: const Text('Criar Conta'),
              onPressed: () {
                _trySignUp(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
