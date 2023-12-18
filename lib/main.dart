import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/routes/app_routes.dart';
import 'package:ammommyappgp/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/constants/firebase_auth_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await FirebaseFirestoreHelper.instance.getWeekInfo();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.standard,
        dividerColor: Colors.transparent,
        primaryColor: const Color(0xffE187B0),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffE187B0)),
        useMaterial3: true,
      ),
      title: 'ammommyappgp',

      debugShowCheckedModeBanner: false,
      routes: AppRoutes.routes,
      // home: const WeightCalculator(),
      home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const SplashScreen(ishome: true);
            }
            return const SplashScreen(ishome: false);
          }),
    );
  }
}

class WeightCalculator extends StatelessWidget {
  final int firstWeekWeight = 50;
  final int secondWeekWeight = 65;
  final int thirdWeekWeight = 32;

  const WeightCalculator({super.key});

  int calculateDifference(int initialWeight, int finalWeight) {
    return finalWeight - initialWeight;
  }

  @override
  Widget build(BuildContext context) {
    int firstSecondDifference =
        calculateDifference(firstWeekWeight, secondWeekWeight);
    int firstThirdDifference =
        calculateDifference(firstWeekWeight, thirdWeekWeight);

    int totalGainLoss = firstSecondDifference - firstThirdDifference;

    String resultText = totalGainLoss > 0
        ? 'Total gain of $totalGainLoss kg'
        : totalGainLoss < 0
            ? 'Total loss of ${totalGainLoss.abs()} kg'
            : 'No change in weight';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'First week - second week: $firstSecondDifference kg',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'First week - third week: $firstThirdDifference kg',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'Answer: $resultText',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
