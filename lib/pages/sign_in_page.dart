import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/pages/base_page.dart';
import 'package:super_task_list/utils/app_routes.dart';

final class SignInPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SignInPage({super.key});

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
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                final db = DBOperations();
                final signIn = db.signIn(
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
              },
              child: const Text('Entrar'),
            ),
            TextButton(
              onPressed: () {
                context.go(AppRoutes.signUpPage);
              },
              child: const Text('Criar uma nova conta'),
            ),
            TextButton(
              onPressed: () {
                context.go(AppRoutes.forgotPasswordPage);
              },
              child: const Text('Esqueci minha senha'),
            ),
          ],
        ),
      ),
    );
  }
}
