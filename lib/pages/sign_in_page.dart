import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/components/fields/email_form_field.dart';
import 'package:super_task_list/components/fields/password_form_field.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/pages/base_page.dart';
import 'package:super_task_list/utils/app_routes.dart';

final class SignInPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  SignInPage({super.key});

  void _trySignIn(BuildContext context) {
    final signIn = DBOperations.signIn(
      _emailController.text,
      _passwordController.text,
    );
    signIn.then((value) {
      if ((value.session == null) && (value.user == null)) {
        throw Exception('Erro ao fazer login!');
      }
      context.go(AppRoutes.homePage);
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
      title: 'Login',
      automaticallyImplyLeading: false,
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
              autofillHints: const [AutofillHints.password],
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              onFieldSubmitted: (value) {
                _trySignIn(context);
              },
            ),
            const SizedBox(
              height: 12,
            ),
            FilledButton(
              onPressed: () {
                _trySignIn(context);
              },
              child: const Text('Entrar'),
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {
                context.push(AppRoutes.signUpPage);
              },
              child: const Text('Criar uma nova conta'),
            ),
            const SizedBox(
              height: 4,
            ),
            TextButton(
              onPressed: () {
                context.push(AppRoutes.forgotPasswordPage);
              },
              child: const Text('Esqueci minha senha'),
            ),
          ],
        ),
      ),
    );
  }
}
