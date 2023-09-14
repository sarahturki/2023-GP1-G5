import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/report_model.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/primary_button.dart';

class VitalInformationEdit extends StatefulWidget {
  final ReportModel reportModel;
  const VitalInformationEdit({super.key, required this.reportModel});

  @override
  State<VitalInformationEdit> createState() => _VitalInformationEditState();
}

class _VitalInformationEditState extends State<VitalInformationEdit> {
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
      appBar: CustomAppBar.getAppBar("معلوماتي 2023/5/22", context),
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
                          labelText:
                              "مستوى السكر في الدم :${widget.reportModel.bloodsuger} ملليغرام/ديسيلتر",
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
                          labelText:
                              "مستوى الضغط في الدم :120/${widget.reportModel.bloodpressure}",
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
                          labelText: " الوزن :${widget.reportModel.weight} كغم",
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
                          labelText:
                              "مستوى فيتامين D :  ${widget.reportModel.vitaminD}   ",
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
                          labelText:
                              "مستوى مستوى الكالسيوم :${widget.reportModel.calcium}",
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
                          labelText:
                              "مستوى الهيموجلوبين : ${widget.reportModel.hemoglobin} غرام",
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
                          ReportModel reportModel = widget.reportModel.copyWith(
                            bloodpressure: bloodpressure.text,
                            bloodsuger: bloodsuger.text,
                            calcium: calcium.text,
                            // dateTime: DateTime.now(),
                            hemoglobin: hemoglobin.text,
                            vitaminD: vitaminD.text,
                            weight: weight.text,
                          );
                          bool isSuccess = await FirebaseFirestoreHelper
                              .instance
                              .updateReports(reportModel);
                          setState(() {
                            isLoading = true;
                          });

                          if (isSuccess) {
                            showMessage("Successfully Added");
                            bloodsuger.clear();
                            bloodpressure.clear();
                            weight.clear();
                            vitaminD.clear();
                            calcium.clear();
                            hemoglobin.clear();

                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop(reportModel);
                          } else {
                            showMessage("Failed");
                          }
                          isLoading = false;

                          setState(() {});
                        },
                        title: "حفظ",
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
