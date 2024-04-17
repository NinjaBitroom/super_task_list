import 'package:go_router/go_router.dart';
import 'package:super_task_list/pages/forgot_password_page.dart';
import 'package:super_task_list/pages/home_page.dart';
import 'package:super_task_list/pages/login_callback_page.dart';
import 'package:super_task_list/pages/sign_in_page.dart';
import 'package:super_task_list/pages/sign_up_page.dart';
import 'package:super_task_list/utils/app_routes.dart';

final router = GoRouter(
  initialLocation: '/signInPage',
  routes: <GoRoute>[
    GoRoute(
      path: AppRoutes.signInPage,
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      path: AppRoutes.signUpPage,
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: AppRoutes.forgotPasswordPage,
      builder: (context, state) => ForgotPasswordPage(),
    ),
    GoRoute(
      path: AppRoutes.homePage,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.loginCallBackPage,
      builder: (context, state) => const LoginCallbackPage(),
    ),
  ],
);
