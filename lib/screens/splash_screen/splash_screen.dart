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
            SizedBox(
                        width: double.maxFinite,
                        height: 250,
                        child: Container(
                          width: double.maxFinite,
                          height: 250,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/img_group56.png'),
                              alignment: Alignment.center,
                              fit: BoxFit.contain,
                            ),
                          ),
                          child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/img_logoremovebgpreview_293x252.png'),
                                      fit: BoxFit.contain))),
                        ),
                      ),
          const Text("أمومي",
              // textAlign: TextAlign.left,
              style: TextStyle(
                color: Color.fromARGB(205, 186, 11, 98),
                fontSize: 50,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
