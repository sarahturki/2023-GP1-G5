import 'package:ammommyappgp/presentation/authentecation/auth.dart';
import 'package:ammommyappgp/presentation/dueDate/PregnancyDueDate.dart';
import 'package:ammommyappgp/presentation/signUp/signUp22.dart';
import 'package:flutter/material.dart';
import 'package:ammommyappgp/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:ammommyappgp/presentation/welcome_screen/welcome_screen.dart';
import 'package:ammommyappgp/presentation/forgot_pass_screen/forgot_pass_screen.dart';
import 'package:ammommyappgp/presentation/homepage/Homepage.dart';



class AppRoutes {
  static const String signInScreen = '/sign_in_screen';



  static const String welcomeScreen = '/welcome_screen';

  static const String forgotPassScreen = '/forgot_pass_screen';


static const String HOMEPAGE = '/Homepage';

static const String AAuth = '/auth';
static const String ssignup22 = '/signUp22';
static const String PregnancyDueDatePageee = '/PregnancyDueDatePage';




  static Map<String, WidgetBuilder> routes = {
    signInScreen: (context) => SignInScreen(),
    welcomeScreen: (context) => WelcomeScreen(),
    forgotPassScreen: (context) => ForgotPassScreen(),
   
    HOMEPAGE :(context) => homepage(), 
    AAuth :(context) => auth(), 
ssignup22 :(context) => signUp22()
,PregnancyDueDatePageee :(context) => PregnancyDueDatePage()


  };
}
