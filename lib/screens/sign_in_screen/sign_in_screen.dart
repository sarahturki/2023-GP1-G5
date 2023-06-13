// ignore_for_file: use_build_context_synchronously

import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/constants/firebase_auth_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
/////////////////////////////////

/////////////////////////controller

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
///////////////////////////////
  ///
  ///
  ///for password icon
  bool _obscureText = true;

/////////////////for sign in

///////////////////////dispoe authentecation

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void opentheforgetpassword() {
    Navigator.of(context).pushNamed('/forgot_pass_screen');
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            _emailController.clear();
            _passwordController.clear();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color:  Color.fromARGB(205, 186, 11, 98),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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

                const SizedBox(height: 15.0),

                ///////////////////////////////////////////email

                ///
                ////////////////////////////////////
                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      labelText: 'البريد الإلكتروني : ',
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 80, 13, 63)),
                      prefixIcon: const Icon(Icons.email_outlined),
                      prefixIconColor: const Color.fromARGB(205, 186, 11, 98),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(205, 186, 11, 98)),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 58, 0, 28)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                /////////////////////////////////////////
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور :',
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 80, 13, 63)),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(205, 186, 11, 98)),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 58, 0, 28)),
                      ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      prefixIconColor: const Color.fromARGB(205, 186, 11, 98),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    obscureText: _obscureText,
                  ),
                ),

                const SizedBox(height: 35.0),

                //////////////////////////////////////////////////////

                //////////////////////////////////////////forget password
                GestureDetector(
                  onTap: opentheforgetpassword,
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text("هل نسيت كلمة السر؟",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromARGB(205, 186, 11, 98),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(
                  height: 40,
                ),

                ////////////////////////////////////////sign in button
                PrimaryButton(
                    onPressed: () async {
                      bool isVaildated = loginVaildation(
                          _emailController.text, _passwordController.text);
                      if (isVaildated) {
                        bool isLogined = await FirebaseAuthHelper.instance
                            .login(_emailController.text,
                                _passwordController.text, context);
                        if (isLogined) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/Homepage", (route) => false);

                          // Routes.instance.pushAndRemoveUntil(
                          //     widget: const CustomBottomBar(), context: context);
                        }
                      }
                    },
                    title: 'تسجيل دخول'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
