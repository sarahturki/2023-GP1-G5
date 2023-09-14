// ignore_for_file: use_build_context_synchronously

import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/user_model.dart';
import 'package:ammommyappgp/screens/change_password/change_password.dart';
import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ///////////////////////

/////////////////////////////////////////////passoword check

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnamecontroller = TextEditingController();
  bool isLoading = false;
  final TextEditingController _birthController = TextEditingController();
  DateTime? selectedDate;
////////////for password icon

//////////////////////for pass validotor

  DateTime? dueDate;

///////////////for sign up

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();

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
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color.fromARGB(205, 186, 11, 98),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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

                      const SizedBox(height: 30.0),

                      ///////////////////////////////////////////name
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _nameController,
                          textInputAction: TextInputAction.next,
                          enableSuggestions: true,
                          decoration: InputDecoration(
                            labelText: userData!.firstName,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            floatingLabelStyle: const TextStyle(
                                color: Color.fromARGB(255, 80, 13, 63)),
                            prefixIcon: const Icon(Icons.person_outline),
                            prefixIconColor:
                                const Color.fromARGB(205, 186, 11, 98),
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
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 0, 28)),
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
                          controller: _lastnamecontroller,
                          enableSuggestions: true,
                          decoration: InputDecoration(
                            labelText: userData!.lastName,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            floatingLabelStyle: const TextStyle(
                                color: Color.fromARGB(255, 80, 13, 63)),
                            prefixIcon: const Icon(Icons.person_outline),
                            prefixIconColor:
                                const Color.fromARGB(205, 186, 11, 98),
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
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 0, 28)),
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

                      const SizedBox(height: 16.0),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          controller: _birthController,
                          enableSuggestions: true,
                          onTap: () async {
                            DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                //which date will display when user open the picker
                                firstDate: DateTime(1950),
                                //what will be the previous supported year in picker
                                lastDate: DateTime.now());

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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 155, 26, 17),
                                ),
                              );
                            }
                          },
                          decoration: InputDecoration(
                            labelText:
                                "${userData!.age!.month}-${userData!.age!.day}-${userData!.age!.year}",
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            floatingLabelStyle: const TextStyle(
                                color: Color.fromARGB(255, 80, 13, 63)),
                            prefixIconColor:
                                const Color.fromARGB(205, 186, 11, 98),
                            prefixIcon: const Icon(Icons.calendar_month),
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
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 0, 28)),
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
                            labelText: userData!.email,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            floatingLabelStyle: const TextStyle(
                                color: Color.fromARGB(255, 80, 13, 63)),
                            prefixIconColor:
                                const Color.fromARGB(205, 186, 11, 98),
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
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 58, 0, 28)),
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

                      // Directionality(
                      //   textDirection: TextDirection.rtl,
                      //   child: TextFormField(
                      //     controller: _birthController,
                      //     enableSuggestions: true,
                      //     onTap: () async {
                      //       DateTime? picked = await showDatePicker(
                      //           context: context,
                      //           initialDate: DateTime.now(),
                      //           //which date will display when user open the picker
                      //           firstDate: DateTime(1950),
                      //           //what will be the previous supported year in picker
                      //           lastDate: DateTime.now());

                      //       if (picked != null) {
                      //         setState(() {
                      //           formatedDuedate =
                      //               intl.DateFormat('dd/MM/yyy').format(picked);
                      //           _birthController.text = formatedDuedate;
                      //           selectedDate = picked;
                      //         });
                      //       } else if (picked == null) {
                      //         setState(() {
                      //           formatedDuedate = "";
                      //           _birthController.text = "";
                      //         });

                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           const SnackBar(
                      //             content: Text(
                      //               'الرجاء ادخال التاريخ بشكل صحيح',
                      //               textAlign: TextAlign.right,
                      //               style: TextStyle(
                      //                   fontSize: 16, fontWeight: FontWeight.bold),
                      //             ),
                      //             backgroundColor: Color.fromARGB(255, 155, 26, 17),
                      //           ),
                      //         );
                      //       }
                      //     },
                      //     decoration: InputDecoration(
                      //       labelText: "موعد الولادة:",
                      //       labelStyle: const TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 15,
                      //       ),
                      //       floatingLabelStyle: const TextStyle(
                      //           color: Color.fromARGB(255, 80, 13, 63)),
                      //       prefixIconColor: const Color.fromARGB(205, 186, 11, 98),
                      //       prefixIcon: const Icon(Icons.calendar_month),
                      //       filled: true,
                      //       fillColor: Colors.white,
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(8.0),
                      //       ),
                      //       enabledBorder: const OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: Color.fromARGB(205, 186, 11, 98)),
                      //       ),
                      //       focusedBorder: const OutlineInputBorder(
                      //         borderSide:
                      //             BorderSide(color: Color.fromARGB(255, 58, 0, 28)),
                      //       ),
                      //     ),
                      //     validator: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'الرجاء تاريخ الميلاد   ';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 16.0,
                      // ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChangePassword(),));
                        },
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text("هل تريد تغيير كلمة السر؟",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromARGB(205, 186, 11, 98),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
///////////////////////////// validator for pass

                      //////////////////////////////////////////////////////
                      const SizedBox(height: 35.0),
                      PrimaryButton(
                          onPressed: () async {
                            UserModel model = userData!;
                            UserModel updateModel = model.copyWith(
                              age: selectedDate,
                              email: _emailController.text.isEmpty
                                  ? null
                                  : _emailController.text,
                              lastName: _lastnamecontroller.text.isEmpty
                                  ? null
                                  : _lastnamecontroller.text,
                             firstName: _nameController.text.isEmpty
                                  ? null
                                  : _nameController.text,
                            );
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseFirestoreHelper.instance
                                .updateUser(updateModel);
                            setState(() {
                              isLoading = false;
                              userData = updateModel;
                            });
                          },
                          title: "تعديل "),

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
}
