import 'package:flutter/material.dart';
import 'package:super_task_list/pages/forgot_password_page.dart';
import 'package:super_task_list/pages/home_page.dart';
import 'package:super_task_list/pages/login_callback_page.dart';
import 'package:super_task_list/pages/sign_in_page.dart';
import 'package:super_task_list/pages/sign_up_page.dart';

final class AppRoutes {
  static const signInPage = '/signInPage';
  static const signUpPage = '/signUpPage';
  static const forgotPasswordPage = '/forgotPasswordPage';
  static const homePage = '/homePage';
  static const loginCallBackPage = '/login-callback';

  static Map<String, WidgetBuilder> define() {
    return {
      signInPage: (BuildContext context) => SignInPage(),
      signUpPage: (BuildContext context) => SignUpPage(),
      forgotPasswordPage: (BuildContext context) => ForgotPasswordPage(),
      homePage: (BuildContext context) => const HomePage(),
      '/login-callback': (BuildContext context) => const LoginCallbackPage(),
    };
  }
}
