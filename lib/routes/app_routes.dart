// ignore_for_file: constant_identifier_names

import 'package:ammommyappgp/screens/authentecation/auth.dart';
import 'package:ammommyappgp/screens/dueDate/pregnancy_due_date.dart';
import 'package:ammommyappgp/screens/home/bottom_bar.dart';
import 'package:ammommyappgp/screens/signUp/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:ammommyappgp/screens/sign_in_screen/sign_in_screen.dart';
import 'package:ammommyappgp/screens/welcome_screen/welcome_screen.dart';
import 'package:ammommyappgp/screens/forgot_pass_screen/forgot_pass_screen.dart';

class AppRoutes {
  static const String signInScreen = '/sign_in_screen';

  static const String welcomeScreen = '/welcome_screen';

  static const String forgotPassScreen = '/forgot_pass_screen';

  static const String HOMEPAGE = '/Homepage';

  static const String AAuth = '/auth';
  static const String ssignup22 = '/signUp22';
  static const String PregnancyDueDatePageee = '/PregnancyDueDatePage';

  static Map<String, WidgetBuilder> routes = {
    signInScreen: (context) => const SignInScreen(),
    welcomeScreen: (context) => const WelcomeScreen(),
    forgotPassScreen: (context) => const ForgotPassScreen(),
    HOMEPAGE: (context) => const CustomBottomBar(),
    AAuth: (context) => const AuthState(),
    ssignup22: (context) => const SignUp(),
    PregnancyDueDatePageee: (context) => const PregnancyDueDatePage()
  };
}
