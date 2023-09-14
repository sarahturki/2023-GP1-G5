import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_appbar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isLoading = false;
  void _changePassword() async {
    setState(() {
      isLoading = true;
    });
    final currentUser = FirebaseAuth.instance.currentUser;

    try {
      await currentUser!.updatePassword(password.text);
      // Password successfully changed
      showMessage("Successfully Changed");
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      if(error.code=="requires-recent-login"){
        showMessage("To Change password you need to login again");
      }else{
      showMessage(error.toString());
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.getAppBar("تغيير كلمة المرور", context),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: password,
                    textInputAction: TextInputAction.next,
                    enableSuggestions: true,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "اكتب كلمة المرور",
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 80, 13, 63)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(205, 186, 11, 98)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromARGB(255, 58, 0, 28)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال الاسم الأول ';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  PrimaryButton(
                      onPressed: () {
                        if (password.text.isNotEmpty) {
                          _changePassword();
                        } else {
                          showMessage("Password is empty");
                        }
                      },
                      title: "تغيير كلمة المرور")
                ],
              ),
            ),
    );
  }
}
