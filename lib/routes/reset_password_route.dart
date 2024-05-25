import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/pages/reset_password_page.dart';

part 'reset_password_route.g.dart';

@TypedGoRoute<ResetPasswordRoute>(path: '/resetPasswordPage')
class ResetPasswordRoute extends GoRouteData {
  const ResetPasswordRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ResetPasswordPage();
}
