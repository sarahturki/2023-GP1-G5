import 'package:ammommyappgp/presentation/homepage/Homepage.dart';
import 'package:ammommyappgp/presentation/sign_in_screen/sign_in_screen.dart';
import 'package:ammommyappgp/presentation/welcome_screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
class auth extends StatelessWidget {
  const auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges()
    ,  builder: (context, snapshot) {
        if (snapshot.hasData) {
          return homepage(); 
        } else {
          return WelcomeScreen(); 
        }
      },
    ),



    );
  }
}