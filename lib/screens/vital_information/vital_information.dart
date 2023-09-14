import 'package:ammommyappgp/models/report_model.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/constants/firebase_firestore_helper.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/primary_button.dart';

class VitalInformation extends StatefulWidget {
  const VitalInformation({super.key});

  @override
  State<VitalInformation> createState() => _VitalInformationState();
}

class _VitalInformationState extends State<VitalInformation> {
  TextEditingController bloodpressure = TextEditingController();
  TextEditingController bloodsuger = TextEditingController();
  bool isLoading = false;
  TextEditingController weight = TextEditingController();

  TextEditingController vitaminD = TextEditingController();

  TextEditingController calcium = TextEditingController();

  TextEditingController hemoglobin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("المعلومات الحيوية ", context),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                // width: 300,
                child: Column(
                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: bloodsuger,
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          labelText: "ادخلي سكر الدم",
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
                    const SizedBox(
                      height: 12,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: bloodpressure,
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          labelText: "ادخلي ضغط الدم ",
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
                    const SizedBox(
                      height: 12.0,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: weight,
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          labelText: "ادخلي الوزن",
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
                    const SizedBox(
                      height: 12.0,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: vitaminD,
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          labelText: "ادخلي مستوى فيتامين D",
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
                    const SizedBox(
                      height: 12.0,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: calcium,
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          labelText: "ادخلي مستوى الكالسيوم",
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
                    const SizedBox(
                      height: 12.0,
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: hemoglobin,
                        textInputAction: TextInputAction.next,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          labelText: "ادخلي مستوى الهيموجلوبين",
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
                    const SizedBox(
                      height: 38.0,
                    ),
                    SizedBox(
                      width: 250,
                      child: PrimaryButton(
                        onPressed: () async {
                          if (bloodpressure.text.isNotEmpty ||
                              bloodsuger.text.isNotEmpty ||
                              weight.text.isNotEmpty ||
                              vitaminD.text.isNotEmpty ||
                              calcium.text.isNotEmpty ||
                              hemoglobin.text.isNotEmpty) {
                            ReportModel reportModel = ReportModel(
                              bloodsuger: bloodsuger.text,
                              dateTime: DateTime.now(),
                              bloodpressure: bloodpressure.text,
                              id: "id",
                              weight: weight.text,
                              vitaminD: vitaminD.text,
                              calcium: calcium.text,
                              hemoglobin: hemoglobin.text,
                            );
                            setState(() {
                              isLoading = true;
                            });
                            bool isSuccess = await FirebaseFirestoreHelper
                                .instance
                                .addReport(reportModel);
                            if (isSuccess) {
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                              showMessage("Successfully Added");
                              bloodsuger.clear();
                              bloodpressure.clear();
                              weight.clear();
                              vitaminD.clear();
                              calcium.clear();
                              hemoglobin.clear();
                            } else {
                              showMessage("Failed");
                            }
                            isLoading = false;

                            setState(() {});
                          } else {
                            showMessage("Please Fill the details");
                          }
                        },
                        title: "اضافة",
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
