import 'package:flutter/material.dart';
import 'package:super_task_list/components/fields/email_form_field.dart';
import 'package:super_task_list/components/fields/password_form_field.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/routes/forgot_password_route.dart';
import 'package:super_task_list/routes/home_route.dart';
import 'package:super_task_list/routes/sign_up_route.dart';

class SignInForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  SignInForm({super.key});

  void _trySignIn(BuildContext context) {
    final signIn = DBOperations.signIn(
      _emailController.text,
      _passwordController.text,
    );
    signIn.then((value) {
      if ((value.session == null) && (value.user == null)) {
        throw Exception('Erro ao fazer login!');
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
    return Form(
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
              const SignUpRoute().push(context);
            },
            child: const Text('Criar uma nova conta'),
          ),
          const SizedBox(
            height: 4,
          ),
          TextButton(
            onPressed: () {
              const ForgotPasswordRoute().push(context);
            },
            child: const Text('Esqueci minha senha'),
          ),
        ],
      ),
    );
  }
}
