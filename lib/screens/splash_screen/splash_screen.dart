import 'package:ammommyappgp/screens/home/bottom_bar.dart';
import 'package:ammommyappgp/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final bool ishome;
  const SplashScreen({super.key, required this.ishome});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => widget.ishome
                  ? const CustomBottomBar()
                  : const WelcomeScreen(),
            ),
            (route) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/logo-removebg-preview 4.png")),
          const Text("أمومي",
              // textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(205, 186, 11, 98),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
