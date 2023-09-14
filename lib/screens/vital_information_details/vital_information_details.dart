import 'package:ammommyappgp/models/report_model.dart';
import 'package:ammommyappgp/screens/vital_information_edit/vital_information_edit.dart';
import 'package:ammommyappgp/widgets/primary_button.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_appbar.dart';

class VitalInformationDetails extends StatefulWidget {
  final ReportModel reportModel;
  const VitalInformationDetails({super.key, required this.reportModel});

  @override
  State<VitalInformationDetails> createState() =>
      _VitalInformationDetailsState();
}

class _VitalInformationDetailsState extends State<VitalInformationDetails> {
  ReportModel? _reportModel;
  @override
  void initState() {
    setState(() {
      _reportModel = widget.reportModel;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("المعلومات الحيوية ", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 12.0,
              ),
              SingleVitalInfoDetailsWidget(
                  title:
                      "مستوى السكر في الدم :${_reportModel!.bloodsuger} ملليغرام/ديسيلتر"),
              const SizedBox(
                height: 12.0,
              ),
              SingleVitalInfoDetailsWidget(
                title:
                    "مستوى الضغط في الدم :120/${_reportModel!.bloodpressure}",
              ),
              const SizedBox(
                height: 12.0,
              ),
              SingleVitalInfoDetailsWidget(
                title: " الوزن :${_reportModel!.weight} كغم",
              ),
              const SizedBox(
                height: 12.0,
              ),
              SingleVitalInfoDetailsWidget(
                title: "${_reportModel!.vitaminD} ميكروغرام : ",
              ),
              const SizedBox(
                height: 12.0,
              ),
              SingleVitalInfoDetailsWidget(
                title: "مستوى الكالسيوم : ${_reportModel!.calcium}",
              ),
              const SizedBox(
                height: 12.0,
              ),
              SingleVitalInfoDetailsWidget(
                title: "مستوى الهيموجلوبين : ${_reportModel!.hemoglobin} غرام",
              ),
              SizedBox(
                width: 250,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 48.0,
                    ),
                    PrimaryButton(
                      onPressed: () async {
                        ReportModel? reportModelNew =
                            await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => VitalInformationEdit(
                              reportModel: _reportModel!,
                            ),
                          ),
                        );
                        if (reportModelNew != null) {
                          setState(() {
                            _reportModel = reportModelNew;
                          });
                        }
                      },
                      title: "تعديل",
                    ),
                    const SizedBox(
                      height: 48.0,
                    ),
                    PrimaryButton(
                      onPressed: () {},
                      title: "حفظ بصيغة PDF",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleVitalInfoDetailsWidget extends StatelessWidget {
  final String title;
  const SingleVitalInfoDetailsWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffFA8BB8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
