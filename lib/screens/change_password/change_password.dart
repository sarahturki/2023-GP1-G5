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

 @override
  void dispose() {
    super.dispose();

    password.dispose();
    _repeatpasswordconroller.dispose();
    
  }
    bool passwordconfiermied() {
    if (password.text.trim() ==
        _repeatpasswordconroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }
  bool isLoading = false;
  void _changePassword() async {
    setState(() {
      isLoading = true;
    });
    final currentUser = FirebaseAuth.instance.currentUser;

    try {
    if (_formKey.currentState!.validate()) {

 if (ispassword8) {
          if (ispasswordhasCapital) {
            if (ispasswordhasSmalLetter) {
              if (ispasswordhasSpiical) {
                if (ispassworhas1num) {
                  if (passwordconfiermied()) {


      
      await currentUser!.updatePassword(password.text);
      // Password successfully changed
      showMessage("تم التغيير بنجاح");
      // ignore: use_build_context_synchronously
      Navigator.pop(context);



                  }}}}}}
    }
    } on FirebaseAuthException catch (error) {
      if(error.code=="requires-recent-login"){
        showMessage("لتغيير كلمة المرور تحتاج إلى تسجيل الدخول مرة أخرى");
      }else{

        if (_formKey.currentState!.validate() == true) {



if (ispassword8 == false) {
        showMessage(
          'كلمة المرور ضعيفة الرجاء اعادة ادخالها',
        );
      } else if (ispasswordhasCapital == false) {
        showMessage(
          'كلمة المرور ضعيفة الرجاء اعادة ادخالها',
        );
      } else if (ispasswordhasSmalLetter == false) {
        showMessage(
          'كلمة المرور ضعيفة الرجاء اعادة ادخالها',
        );
      } else if (ispasswordhasSpiical == false) {
        showMessage(
          'كلمة المرور ضعيفة الرجاء اعادة ادخالها',
        );
      } else if (ispassworhas1num == false) {
        showMessage(
          'كلمة المرور ضعيفة الرجاء اعادة ادخالها',
        );
      } 



        }
      }
    }
    setState(() {
      isLoading = false;
    });
  } 
  
  /////////////////////for pass validotor
    final _formKey = GlobalKey<FormState>();

  bool ispassword8 = false;
  bool ispassworhas1num = false;
  bool ispasswordhasCapital = false;
  bool ispasswordhasSpiical = false;
  DateTime? dueDate;
  bool ispasswordhasSmalLetter = false;

  onPasswordChange(String password) {
    final numricregex = RegExp(r'[0-9]');
    final capitalregex = RegExp(r'[A-Z]');
    final smallregex = RegExp(r'[a-z]{1}');
    final speialregex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    setState(() {
      ispassword8 = false;
      if (password.length >= 8) {
        ispassword8 = true;
      }
/////////////////////////
      ispassworhas1num = false;
      if (numricregex.hasMatch(password)) {
        ispassworhas1num = true;
      }
/////////////
      ispasswordhasCapital = false;
      if (capitalregex.hasMatch(password)) {
        ispasswordhasCapital = true;
      }

///////////
      ispasswordhasSmalLetter = false;
      if (smallregex.hasMatch(password)) {
        ispasswordhasSmalLetter = true;
      }
///////////////
      ispasswordhasSpiical = false;
      if (speialregex.hasMatch(password)) {
        ispasswordhasSpiical = true;
      }
    });
  }
   bool _obscureText = true;


  TextEditingController password = TextEditingController();
    final TextEditingController _repeatpasswordconroller =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar.getAppBar("تغيير كلمة المرور", context),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(
                  child: Form(
                                key: _formKey,
                
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                               const SizedBox(
                  height: 100,
                ),

                  
                        Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: password,
                          onChanged: (password) => onPasswordChange(password),
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'كلمة المرور :',
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            floatingLabelStyle: const TextStyle(
                                color: Color.fromARGB(255, 80, 13, 63)),
                            enabledBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color.fromARGB(205, 186, 11, 98)),
                            ),
                            focusedBorder: const OutlineInputBorder(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'الرجاء ادخال  كلمة المرور ';
                            }
                            return null;
                          },
                        ),
                      ),
                            
                            
                         const SizedBox(
                        height: 20,
                      ),
                            
                            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(' طول كلمة السر على الأقل 8 خانات'),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color:
                                    ispassword8 ? Colors.green : Colors.transparent,
                                border: ispassword8
                                    ? Border.all(color: Colors.transparent)
                                    : Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                            
                      const SizedBox(
                        height: 10,
                      ),
                            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(' تحتوي كلمة السر على الأقل رقم واحد  '),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: ispassworhas1num
                                    ? Colors.green
                                    : Colors.transparent,
                                border: ispassworhas1num
                                    ? Border.all(color: Colors.transparent)
                                    : Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                            
                      const SizedBox(
                        height: 10,
                      ),
                            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(' تحتوي كلمة السر على الأقل حرف واحد كبير'),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: ispasswordhasCapital
                                    ? Colors.green
                                    : Colors.transparent,
                                border: ispasswordhasCapital
                                    ? Border.all(color: Colors.transparent)
                                    : Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                            
                      const SizedBox(
                        height: 10,
                      ),
                            
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(' تحتوي كلمة السر على الأقل حرف صغيرة'),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: ispasswordhasSmalLetter
                                    ? Colors.green
                                    : Colors.transparent,
                                border: ispasswordhasSmalLetter
                                    ? Border.all(color: Colors.transparent)
                                    : Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                            
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                              '  تحتوي كلمة السر على الأقل رمز واحد مميز مثل: @,. '),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: ispasswordhasSpiical
                                    ? Colors.green
                                    : Colors.transparent,
                                border: ispasswordhasSpiical
                                    ? Border.all(color: Colors.transparent)
                                    : Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                            
                      const SizedBox(
                        height: 10,
                      ),
                            
                            
                                 const SizedBox(
                          height: 28.0,
                        ),
                        Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _repeatpasswordconroller,
                          textInputAction: TextInputAction.done,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: ' إعادة كلمة المرور :',
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            floatingLabelStyle: const TextStyle(
                                color: Color.fromARGB(255, 80, 13, 63)),
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
                              return 'الرجاء ادخال  إعادة كلمة المرور ';
                            }
                            return null;
                          },
                        ),
                      ),
                            
                        const SizedBox(
                          height: 98.0,
                        ),
                            
                            
                            
                        PrimaryButton(
                            onPressed: () {
                              if (password.text.isNotEmpty) {
                                if
                                (passwordconfiermied()==true){
                                _changePassword();}
                            else  {  

                            if (passwordconfiermied() == false) {
        showMessage(
          'كلمة المرور غير متطابقة الرجاء اعادة ادخالها',
        );
      }

if (ispassword8 == false) {
        showMessage(
          'كلمة المرور ضعيفة الرجاء اعادة ادخالها',
        );
      } else if (ispasswordhasCapital == false) {
        showMessage(
          'كلمة المرور ضعيفة الرجاء اعادة ادخالها',
        );
      } else if (ispasswordhasSmalLetter == false) {
        showMessage(
          'كلمة المرور ضعيفة الرجاء اعادة ادخالها',
        );
      } else if (ispasswordhasSpiical == false) {
        showMessage(
          'كلمة المرور ضعيفة الرجاء اعادة ادخالها',
        );
      } else if (ispassworhas1num == false) {
        showMessage(
          'كلمة المرور ضعيفة الرجاء اعادة ادخالها',
        );
      } 
      
                            }
                            
                            
                              } else {
                                showMessage("كلمة المرور فارغة");
                              }
                            },
                            title: "تغيير كلمة المرور")
                      ],
                    ),
                  ),
                ),
              ),
          ),
    );
  }
}
