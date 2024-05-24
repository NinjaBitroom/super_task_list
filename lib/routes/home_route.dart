import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/pages/home_page.dart';
import 'package:super_task_list/routes/forgot_password_route.dart';
import 'package:super_task_list/routes/reset_password_route.dart';
import 'package:super_task_list/routes/sign_in_route.dart';
import 'package:super_task_list/routes/sign_up_route.dart';

part 'home_route.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [
    TypedGoRoute<SignInRoute>(path: 'signInPage'),
    TypedGoRoute<SignUpRoute>(path: 'signUpPage'),
    TypedGoRoute<ForgotPasswordRoute>(path: 'forgotPasswordPage'),
    TypedGoRoute<ResetPasswordRoute>(path: 'resetPasswordPage'),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    if (state.fullPath != '/') return null;
    final auth = DBOperations.db.auth;
    if ((auth.currentUser == null) || (auth.currentSession == null)) {
      return const SignInRoute().location;
    }
    return null;
  }
}
