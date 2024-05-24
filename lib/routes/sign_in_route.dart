import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/pages/sign_in_page.dart';

class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => SignInPage();
}
