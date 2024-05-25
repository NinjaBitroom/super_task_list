import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/pages/sign_up_page.dart';

part 'sign_up_route.g.dart';

@TypedGoRoute<SignUpRoute>(path: '/sign-up')
final class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const SignUpPage();
}
