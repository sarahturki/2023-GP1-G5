
import 'package:ammommyappgp/presentation/dueDate/PregnancyDueDate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ammommyappgp/presentation/welcome_screen/welcome_screen.dart';

import 'package:ammommyappgp/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ammommyappgp/presentation/authentecation/auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
      ),
      title: 'ammommyappgp',
         localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          //     const Locale('en', 'USA'),
          const Locale('ar', 'SA'),
        ],
      debugShowCheckedModeBanner: false,
      routes:   AppRoutes.routes,
     home: auth(),
    );
  }
}
