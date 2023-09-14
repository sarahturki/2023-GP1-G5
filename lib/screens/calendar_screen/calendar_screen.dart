import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/appointments_model.dart';
import 'package:ammommyappgp/screens/my_appointments/my_appointments.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/primary_button.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  bool isAdd = false;
  bool isLoading = false;

  final TextEditingController title = TextEditingController();
  final TextEditingController subtitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("التقويم", context),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  TableCalendar(
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: const Color(0xffE187B0).withOpacity(0.5),
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
                    onDaySelected: (selectedDay, focusedDay) {
                      _focusedDay = focusedDay;

                      setState(() {});
                    },
                    // calendarController: _calendarController,
                    // Customize the calendar appearance and behavior as needed.
                    // For example, you can set properties like initialCalendarFormat,
                    // availableCalendarFormats, headerStyle, calendarStyle, etc.
                    // Check the documentation for all customization options.
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  isAdd
                      ? SizedBox(
                          width: 300,
                          child: Column(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  controller: title,
                                  textInputAction: TextInputAction.next,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                    labelText: 'عنوان الموعد',
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
                                          color:
                                              Color.fromARGB(205, 186, 11, 98)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 58, 0, 28)),
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
                                  maxLines: 5, //or null
                                  controller: subtitle,
                                  textInputAction: TextInputAction.next,
                                  enableSuggestions: true,
                                  decoration: InputDecoration(
                                    labelText: "ملاحظات",
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
                                          color:
                                              Color.fromARGB(205, 186, 11, 98)),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 58, 0, 28)),
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
                              SizedBox(
                                width: 250,
                                child: PrimaryButton(
                                  onPressed: () async {
                                    if (title.text.isNotEmpty &&
                                        subtitle.text.isNotEmpty) {
                                      AppointmentsModel appointmentsModel =
                                          AppointmentsModel(
                                              title: title.text,
                                              desription: subtitle.text,
                                              dateTime: _focusedDay,
                                              id: "@");
                                      setState(() {
                                        isLoading = true;
                                      });
                                      bool isSuccess =
                                          await FirebaseFirestoreHelper.instance
                                              .addAppointment(
                                                  appointmentsModel);
                                      if (isSuccess) {
                                        showMessage("Successfully Added");
                                        title.clear();
                                        subtitle.clear();
                                        isAdd = false;
                                      } else {
                                        showMessage("Failed");
                                      }
                                      isLoading = false;

                                      setState(() {});
                                    } else {
                                      showMessage("Please Fill the details");
                                    }
                                  },
                                  title: "ادخال موعد جديد",
                                ),
                              ),
                              const SizedBox(
                                height: 12.0,
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          width: 250,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 48.0,
                              ),
                              PrimaryButton(
                                onPressed: () {
                                  setState(() {
                                    isAdd = true;
                                  });
                                },
                                title: "ادخال موعد جديد",
                              ),
                              const SizedBox(
                                height: 48.0,
                              ),
                              PrimaryButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const MyAppointments(),
                                  ));
                                },
                                title: "مواعيدي",
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
