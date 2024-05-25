import 'package:go_router/go_router.dart';
import 'package:super_task_list/routes/forgot_password_route.dart' as fpr;
import 'package:super_task_list/routes/home_route.dart' as hr;
import 'package:super_task_list/routes/reset_password_route.dart' as rpr;
import 'package:super_task_list/routes/sign_in_route.dart' as sir;
import 'package:super_task_list/routes/sign_up_route.dart' as sur;

abstract final class AppRouter {
  static final router = GoRouter(routes: routes);

  static final routes = [
    ...sir.$appRoutes,
    ...sur.$appRoutes,
    ...fpr.$appRoutes,
    ...rpr.$appRoutes,
    ...hr.$appRoutes,
  ];
}
