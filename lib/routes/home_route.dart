import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/pages/home_page.dart';
import 'package:super_task_list/routes/sign_in_route.dart';

part 'home_route.g.dart';

@TypedGoRoute<HomeRoute>(path: '/')
final class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomePage();

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    final auth = DBOperations.db.auth;
    if ((auth.currentUser == null) || (auth.currentSession == null)) {
      return const SignInRoute().location;
    }
    return null;
  }
}
