import 'package:go_router/go_router.dart';
import 'package:super_task_list/database/db_operations.dart';
import 'package:super_task_list/pages/forgot_password_page.dart';
import 'package:super_task_list/pages/home_page.dart';
import 'package:super_task_list/pages/reset_password_page.dart';
import 'package:super_task_list/pages/sign_in_page.dart';
import 'package:super_task_list/pages/sign_up_page.dart';

final class AppRoutes {
  static final router = _getRouter();
  static const homePage = '/';
  static const signInPage = '/signInPage';
  static const signUpPage = '/signUpPage';
  static const forgotPasswordPage = '/forgotPasswordPage';
  static const resetPasswordPage = '/resetPasswordPage';

  static GoRouter _getRouter() {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: homePage,
          builder: (context, state) => const HomePage(),
          redirect: (context, state) {
            final db = DBOperations();
            final auth = db.db.auth;
            if ((auth.currentUser == null) || (auth.currentSession == null)) {
              return signInPage;
            }
            return null;
          },
        ),
        GoRoute(
          path: signInPage,
          builder: (context, state) => SignInPage(),
        ),
        GoRoute(
          path: signUpPage,
          builder: (context, state) => SignUpPage(),
        ),
        GoRoute(
          path: forgotPasswordPage,
          builder: (context, state) => ForgotPasswordPage(),
        ),
        GoRoute(
          path: resetPasswordPage,
          builder: (context, state) => ResetPasswordPage(),
        ),
      ],
    );
  }
}
