// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:ammommyappgp/core/app_export.dart';
import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import '../../core/constants/firebase_firestore_helper.dart';

class PregnancyDueDatePage extends StatefulWidget {
  const PregnancyDueDatePage({super.key});

  @override
  _PregnancyDueDatePageState createState() => _PregnancyDueDatePageState();
}

class _PregnancyDueDatePageState extends State<PregnancyDueDatePage> {
  DateTime? selectedDate;
  bool _isvisible = false;
 
  String formatedDuedate = "";
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Center(
            child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                 const SizedBox(
                  height: 30,
                ),
               Container(
                    width: double.maxFinite,
                    height: 320,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img_group56.png'),
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: Container(
                        width: 170,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/img_logoremovebgpreview_293x252.png'),
                                fit: BoxFit.contain))),
                  ),
      
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  "يرجى ادخال تاريخ بداية اخر دورة شهرية",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(205, 186, 11, 98),
                  ),
                ),
                const Text(
                  "(تاريخ اول يوم من اخر دورة)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(205, 96, 95, 96),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                      width: 180,
                      child: PrimaryButton(
                          onPressed: () => _selectDate(context),
                          title: 'أضغط هنا ')),
                ),
             
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   
                    Container(
                      padding: const EdgeInsets.all(25.0),
                      child: Center(
                        child: Visibility(
                          visible: _isvisible,
                          child: Text(
                            ': الموافق  \n  $formatedDuedate ',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(205, 87, 12, 49),
                                fontFamily: AppRoutes.welcomeScreen,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      const SizedBox(height: 30,)
      ,
                SizedBox(
                  width: 300,
              
                  child: PrimaryButton(
                     onPressed: () async {
                    if (selectedDate == null) {
                      showMessage(
                        'الرجاء ادخال التاريخ بشكل صحيح',
                      );
                    } else {
                      await FirebaseFirestoreHelper.instance
                          .senddate(selectedDate!, context);
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/Homepage", (route) => false);
                    }
                  },
                    title: 'ابدأي رحلتك الآن',
                  ),
                ),
         
              ],
            ),
          ),
        ),
      ),
    );
  } Future<void> _selectDate(BuildContext context) async {
    DateTime subtractedDate =
        DateTime.now().subtract(const Duration(days: 280));
    DateTime lastDate = DateTime.now().subtract(const Duration(days: 8));

    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: lastDate,
        //which date will display when user open the picker
        firstDate: subtractedDate,
        //what will be the previous supported year in picker
        lastDate: lastDate);

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });

      setState(() {
        _isvisible = true;
      });

      //////////////////////////////////format from  hijri To Gregorian

////////////////////due date

      setState(() {
        formatedDuedate = DateFormat('dd/MM/yyy').format(selectedDate!);
      });

///////////////////////
    } else if (picked == null) {
      setState(() {
        _isvisible = false;
      });

      setState(() {
        formatedDuedate = "";
      });

      showMessage(
        'الرجاء ادخال التاريخ بشكل صحيح',
      );
    }
  }


  String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }

    return input;
  }
}
