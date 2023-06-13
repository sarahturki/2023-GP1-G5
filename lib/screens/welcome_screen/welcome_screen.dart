import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:ammommyappgp/core/app_export.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void openSignInScreen() {
      Navigator.of(context).pushNamed('/sign_in_screen');
    }

    void openSignUPScreen() {
      Navigator.of(context).pushNamed('/signUp22');
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: kToolbarHeight,
                      ),
                      Container(
                        width: double.maxFinite,
                        height: 360,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/img_group56.png'),
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                          ),
                        ),
                        child: Container(
                            width: 180,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/img_logoremovebgpreview_293x252.png'),
                                    fit: BoxFit.contain))),
                      ),
                      const SizedBox(
                        height: kTextTabBarHeight * 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            PrimaryButton(
                              
                              onPressed: openSignInScreen,
                              title: "تسجيل الدخول",
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            PrimaryButton(
                              onPressed: openSignUPScreen,
                              title: "حساب جديد",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
