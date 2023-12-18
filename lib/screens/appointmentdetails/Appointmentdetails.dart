import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/appointments_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/primary_button.dart';

class Appointmentdetails extends StatefulWidget {
  final AppointmentsModel appointmentsModel;
  const Appointmentdetails({super.key, required this.appointmentsModel});

  @override
  State<Appointmentdetails> createState() => _AppointmentdetailsState();
}

class _AppointmentdetailsState extends State<Appointmentdetails> {

  AppointmentsModel? _reportModel;
  
  @override

  DateTime _focusedDay = DateTime.now();
  final TextEditingController title = TextEditingController();
  final TextEditingController subtitle = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    _focusedDay = widget.appointmentsModel.dateTime;
    title.text = widget.appointmentsModel.title;
    subtitle.text = widget.appointmentsModel.desription;
     setState(() {
      _reportModel = widget.appointmentsModel;
    });
    super.initState();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar(title.text, context),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  TableCalendar(
                      headerStyle: const HeaderStyle(
                            formatButtonVisible: false, titleCentered: true),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 146, 146, 146).withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: Color(0xffE187B0),
                        shape: BoxShape.circle,
                      ),
                    ),
                    focusedDay:
                        _focusedDay, // Set it to the currently selected day
                    firstDay: DateTime.now().subtract(
                        const Duration(days: 365)), // One year ago from today
                    lastDay: DateTime.now()
                        .add(const Duration(days: 365)), // One year from today
                    selectedDayPredicate: (date) {
                      // Return true if the date matches the selected day, else false
                      return isSameDay(date, _focusedDay);
                    },
                    onFormatChanged: (format) {},
                  
                 
                  ),


                  ////////////////////////////////////////////////////////
                  ///
                  ///
                  ///

SizedBox(height: 30,) ,



const Directionality(
  textDirection: TextDirection.rtl,
  child:   Text(" الموعد:" ,                         textDirection: TextDirection.rtl , style: TextStyle(
                           
                              fontSize: 18,
                              color: Color.fromARGB(205, 59, 10, 35),
                          fontWeight: FontWeight.bold,
                        ),
  
  ),
) ,

Singleapp(title:                         widget.appointmentsModel.title.trim(),


)
,


SizedBox(height: 20,) ,

const Directionality(
  textDirection: TextDirection.rtl,
  child:   Text(" الملاحظات:" ,                         textDirection: TextDirection.rtl , style: TextStyle(
                           
                              fontSize: 18,
                              color: Color.fromARGB(205, 59, 10, 35),
                          fontWeight: FontWeight.bold,
                        ),
  
  ),
) ,

Singleapp(title:                         widget.appointmentsModel.desription.trim(),


)
,
const SizedBox(height: 50,) ,





                ],
              ),
            ),
    );
  }
}



class Singleapp extends StatelessWidget {
  final String title;
  const Singleapp({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        color: const Color(0xffFA8BB8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          alignment: Alignment.topRight,
          child: Text(
            title,
      textDirection: TextDirection.rtl,
            style: const TextStyle(
              
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}