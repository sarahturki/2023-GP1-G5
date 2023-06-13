// ignore_for_file: use_build_context_synchronously

import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/core/constants/firebase_auth_helper.dart';
import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

final _emailconroller = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _ForgotPassScreenState extends State<ForgotPassScreen> {
////////////////////////////fincoin for button
  Future restpass() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuthHelper.instance
            .forgetPassword(_emailconroller.text, context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            '! تم الارسال , تحقق من ايميلك ',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.teal,
        ));
     

        Navigator.of(context).pop();
      } on FirebaseAuthException {
        Navigator.of(context, rootNavigator: true).pop();

        showMessage(
          ' فشل الارسال , تحقق من الايميل المدخل  !',
        );
      }
    }
  }

///////////////////////////nevegitor for pink arrow

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              _emailconroller.clear();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color:  Color.fromARGB(205, 186, 11, 98),
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 30,
                  ),


                  SizedBox(
                    width: double.maxFinite,
                    height: 350,
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

                  const SizedBox(
                    height: 50,
                  ),

                  const Text(
                    "لتغيير كلمة المرور الخاصة بك \n  الرجاء ادخال ايميلك الالكتروني ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(205, 186, 11, 98),
                    ),
                  )

                  ///
                  ////////////////////////////////////
                  ,
                  const SizedBox(
                    height: 30,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      controller: _emailconroller,
                      textInputAction: TextInputAction.next,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        labelText: 'البريد الإلكتروني : ',
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        floatingLabelStyle: const TextStyle(
                            color: Color.fromARGB(255, 80, 13, 63)),
                        prefixIconColor: const Color.fromARGB(205, 186, 11, 98),
                        prefixIcon: const Icon(Icons.email_outlined),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(205, 186, 11, 98)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 58, 0, 28)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء ادخال البريد الإلكتروني   ';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  //////////////////////////////////////////////////////
                  const SizedBox(height: 45.0),

////////////////////////////////////////
                  PrimaryButton(
                    onPressed: restpass,
                    title: "ارسال",
                  ),
                ],
              ),
            ),
          ),
        ));


  }
}
