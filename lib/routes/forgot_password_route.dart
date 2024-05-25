import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/pages/forgot_password_page.dart';

part 'forgot_password_route.g.dart';

@TypedGoRoute<ForgotPasswordRoute>(path: '/forgotPasswordPage')
class ForgotPasswordRoute extends GoRouteData {
  const ForgotPasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ForgotPasswordPage();
}
