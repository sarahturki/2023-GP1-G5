import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/appointments_model.dart';
import 'package:ammommyappgp/screens/calendar_screen_edit.dart/calendar_screen_edit.dart';
import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class MyAppointments extends StatelessWidget {
  const MyAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("مواعيدي", context),
      body: StreamBuilder(
        stream: FirebaseFirestoreHelper.instance.getAppoinment(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              AppointmentsModel singleAppo = snapshot.data![index];
              return SingleAppointmentWidget(
                appointmentsModel: singleAppo,
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}

class SingleAppointmentWidget extends StatelessWidget {
  final AppointmentsModel appointmentsModel;
  final int index;
  const SingleAppointmentWidget({
    super.key,
    required this.appointmentsModel,
    required this.index,

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
                  onPressed: ()async {
                 await   FirebaseFirestoreHelper.instance.deleteAppointment(appointmentsModel.id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CalendarScreenEdit(
                          appointmentsModel: appointmentsModel),
                    ));
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${index + 1}  ${appointmentsModel.title}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${appointmentsModel.dateTime.year}/${appointmentsModel.dateTime.month}/${appointmentsModel.dateTime.day}",
                  style: const TextStyle(
                    fontSize: 13,
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
