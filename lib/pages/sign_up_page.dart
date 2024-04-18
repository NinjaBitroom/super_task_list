import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/pages/base_page.dart';
import 'package:super_task_list/utils/app_routes.dart';

final class SignUpPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  SignUpPage({super.key});

  void _trySignUp(BuildContext context) {
    final db = DBOperations();
    final signUp = db.signUp(
      _emailController.text,
      _passwordController.text,
    );
    signUp.then((value) {
      if ((value.session == null) && (value.user == null)) {
        throw Exception('Erro ao criar conta!');
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
      title: 'Criar Conta',
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
              autofocus: true,
              onFieldSubmitted: (value) {
                _passwordFocusNode.requestFocus();
              },
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Senha'),
              focusNode: _passwordFocusNode,
              onFieldSubmitted: (value) {
                _trySignUp(context);
              },
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
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
