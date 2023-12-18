// ignore_for_file: use_build_context_synchronously

import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

import '../../core/constants/firebase_auth_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  ///////////////////////

/////////////////////////////////////////////passoword check
  bool passwordconfiermied() {
    if (_passwordController.text.trim() ==
        _repeatpasswordconroller.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnamecontroller = TextEditingController();
  final TextEditingController _repeatpasswordconroller =
      TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  DateTime? selectedDate;
////////////for password icon
  bool _obscureText = true;

//////////////////////for pass validotor
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

///////////////for sign up

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _repeatpasswordconroller.dispose();
    _nameController.dispose();
    _lastnamecontroller.dispose();
    _birthController.dispose();
  }

//////////////  format for dates

  String newDate = "";
  String formatedDuedate = "12/2/2020";
  num age = 0;
////////////////////////////////

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
            color: Color.fromARGB(205, 186, 11, 98),
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

                const SizedBox(height: 30.0),

                ///////////////////////////////////////////name
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(

                                            maxLength: 10 ,

                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                                                                                                        counterText: "الحد الأقصى 10 حروف",

                      labelText: 'الاسم الأول  :',
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 80, 13, 63)),
                      prefixIcon: const Icon(Icons.person_outline),
                      prefixIconColor: const Color.fromARGB(205, 186, 11, 98),
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
                ),

                const SizedBox(height: 16.0),

                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                                            maxLength: 10 ,

                    controller: _lastnamecontroller,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                                                                                                        counterText: "الحد الأقصى 10 حروف",

                      labelText: 'الاسم الأخير :',
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 80, 13, 63)),
                      prefixIcon: const Icon(Icons.person_outline),
                      prefixIconColor: const Color.fromARGB(205, 186, 11, 98),
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
                        return 'الرجاء ادخال الاسم الأخير ';
                      }
                      return null;
                    },
                  ),
                ),

                ///
                ///
                ///
                ////////////////////////////////////birthdate

                const SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _birthController,
                    enableSuggestions: true,
                    onTap: () async {
                      int year = DateTime.now().year - 18;
                      DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(
                              year, DateTime.now().month, DateTime.now().day),
                          //which date will display when user open the picker
                          firstDate: DateTime(1950),
                          //what will be the previous supported year in picker
                          lastDate: DateTime(
                              year, DateTime.now().month, DateTime.now().day));

                      if (picked != null) {
                        setState(() {
                          formatedDuedate =
                              intl.DateFormat('dd/MM/yyy').format(picked);
                          _birthController.text = formatedDuedate;
                          selectedDate = picked;
                        });
                      } else if (picked == null) {
                        setState(() {
                          formatedDuedate = "";
                          _birthController.text = "";
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'الرجاء ادخال التاريخ بشكل صحيح',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            backgroundColor: Color.fromARGB(255, 155, 26, 17),
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'تاريخ الميلاد: ',
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      floatingLabelStyle: const TextStyle(
                          color: Color.fromARGB(255, 80, 13, 63)),
                      prefixIconColor: const Color.fromARGB(205, 186, 11, 98),
                      prefixIcon: const Icon(Icons.calendar_month),
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
                        return 'الرجاء تاريخ الميلاد   ';
                      }
                      return null;
                    },
                  ),
                ),

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
                        return 'الرجاء ادخال البريد الإلكتروني   ';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 16.0),

                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _passwordController,
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

                const SizedBox(height: 16.0),

///////////////////////////// validator for pass

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

                //////////////////////////////////////////////////////
                const SizedBox(height: 35.0),
                PrimaryButton(
                  onPressed: _signup,
                  title: 'إنشاء حساب',
                ),

                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      if (formatedDuedate != "") {
        if (ispassword8) {
          if (ispasswordhasCapital) {
            if (ispasswordhasSmalLetter) {
              if (ispasswordhasSpiical) {
                if (ispassworhas1num) {
                  if (passwordconfiermied()) {
                    if (selectedDate != null) {
                      bool isLogined = await FirebaseAuthHelper.instance.signUp(
                          _nameController.text.trim(),
                          _emailController.text.trim(),
                          _passwordController.text,
                          context,
                          _lastnamecontroller.text.trim(),
                          selectedDate!);
                      if (isLogined) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/PregnancyDueDatePage", (route) => false);
                      }
                    }

                    // try
                  }
                }
                ////////////
              }
            }
          }
        }
      }
    }

    if (_formKey.currentState!.validate() == true) {
      if (formatedDuedate == "") {
        showMessage(
          'الرجاء ادخال التاريخ بشكل صحيح',
        );
      } else if (ispassword8 == false) {
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
      } else if (passwordconfiermied() == false) {
        showMessage(
          'كلمة المرور غير متطابقة الرجاء اعادة ادخالها',
        );
      }
    }
  }
}
