import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/appointments_model.dart';
import 'package:ammommyappgp/screens/calendar_screen/calendar_screen.dart';
import 'package:ammommyappgp/screens/calendar_screen_edit.dart/calendar_screen_edit.dart';
import 'package:ammommyappgp/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../appointmentdetails/Appointmentdetails.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({Key? key, }) : super(key: key);

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {

  late List<AppointmentsModel> appointmentsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      toolbarHeight: 126,
      backgroundColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(50),
        ),
      ),
      centerTitle: true,
      title: const Text(
        "مواعيدي",
        style: TextStyle(color: Colors.white, fontSize: 32),
      ),
 leading: IconButton(
          onPressed: () {
           Navigator.pop(context);

          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(205, 255, 255, 255),
          ),
        ),
    ) , 
      body:
             

       StreamBuilder(
        
        stream: FirebaseFirestoreHelper.instance.getAppoinment(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } 
          

          appointmentsList = List.from(snapshot.data!);
          return ListView.builder(
            shrinkWrap: true,
            itemCount: appointmentsList.length,
            itemBuilder: (context, index) {
              AppointmentsModel singleAppo = appointmentsList[index];
              return  SingleAppointmentWidget(
                appointmentsModel: singleAppo,
                index: index,
                onDelete: () {

                   
                  setState(() {
                    appointmentsList.removeAt(index);
                                appointmentsList.remove(singleAppo);

                  });
                  setState(() {
                    
                  });
                },
              );
              
            },
          );
        },
      ),
    );
  }
}

class SingleAppointmentWidget extends StatefulWidget {
  final AppointmentsModel appointmentsModel;
  final int index;
  final Function onDelete; // Add this line

  const SingleAppointmentWidget({
    super.key,
    required this.appointmentsModel,
    required this.index,
    required this.onDelete, 
  });

  @override
  State<SingleAppointmentWidget> createState() =>
      _SingleAppointmentWidgetState();
}

class _SingleAppointmentWidgetState extends State<SingleAppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:     () {

                    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Appointmentdetails( appointmentsModel: widget.appointmentsModel)),
  );
                },
      child: Card(
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
                      Widget cancelButton = TextButton(
                        child: const Text("تراجع"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                      Widget continueButton = TextButton(
                        child: const Text("حذف"),
                        onPressed: ()async {
    
    
                           FirebaseFirestoreHelper.instance
                              .deleteAppointment(widget.appointmentsModel.id);
                          Navigator.of(context).pop();
                                        widget.onDelete();
    
    
    
    setState(() {
      
      
    });
    
                        },
                      );
    
                      AlertDialog alert = AlertDialog(
                        title: const Text(
                          "حذف  الموعد",
                          textAlign: TextAlign.right,
                        ),
                        content: const Text(
                          "هل أنتي متأكدة؟",
                          textAlign: TextAlign.right,
                        ),
                        actions: [
                          cancelButton,
                          continueButton,
                        ],
                      );
    
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
    
                      setState(() {});
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
                            appointmentsModel: widget.appointmentsModel),
                      ));
                      setState(() {});
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
                    widget.appointmentsModel.title,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${widget.appointmentsModel.dateTime.year}/${widget.appointmentsModel.dateTime.month}/${widget.appointmentsModel.dateTime.day}",
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
      ),
    );
  }
}
