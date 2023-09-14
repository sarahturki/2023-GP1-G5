import 'package:ammommyappgp/models/report_model.dart';
import 'package:ammommyappgp/screens/vital_information/vital_information.dart';
import 'package:ammommyappgp/screens/vital_information_details/vital_information_details.dart';
import 'package:flutter/material.dart';

import '../../core/constants/firebase_firestore_helper.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/primary_button.dart';

class VitalInformationView extends StatelessWidget {
  const VitalInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("المعلومات الحيوية ", context),
      body: StreamBuilder(
        stream: FirebaseFirestoreHelper.instance.getReport(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  ReportModel reportModel = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => VitalInformationDetails(
                            reportModel: reportModel,
                          ),
                        ),
                      );
                    },
                    child: SingleVitalInfoWidget(
                      title: "معلوماتي",
                      id: reportModel.id,
                      subtitle:
                          "${reportModel.dateTime.year}/${reportModel.dateTime.month}/${reportModel.dateTime.day}",
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 28.0,
              ),
              SizedBox(
                width: 200,
                child: PrimaryButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VitalInformation(),
                    ));
                  },
                  title: "اضافة",
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SingleVitalInfoWidget extends StatelessWidget {
  final String title, subtitle, id;
  const SingleVitalInfoWidget({
    super.key,
    required this.subtitle,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffFA8BB8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    await FirebaseFirestoreHelper.instance.deleteReport(id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$title  $subtitle",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
