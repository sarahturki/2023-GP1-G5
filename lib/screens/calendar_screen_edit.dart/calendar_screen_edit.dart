import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/appointments_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/custom_appbar.dart';
import '../../widgets/primary_button.dart';

class CalendarScreenEdit extends StatefulWidget {
  final AppointmentsModel appointmentsModel;
  const CalendarScreenEdit({super.key, required this.appointmentsModel});

  @override
  State<CalendarScreenEdit> createState() => _CalendarScreenEditState();
}

class _CalendarScreenEditState extends State<CalendarScreenEdit> {
  DateTime _focusedDay = DateTime.now();
  final TextEditingController title = TextEditingController();
  final TextEditingController subtitle = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    _focusedDay = widget.appointmentsModel.dateTime;
    title.text = widget.appointmentsModel.title;
    subtitle.text = widget.appointmentsModel.desription;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar( title.text , context),
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
                  SizedBox(
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
                              labelText: "عنوان الموعد" ,
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
                            maxLines: 5, //or null
                            controller: subtitle,
                            textInputAction: TextInputAction.next,
                            enableSuggestions: true,
                            decoration: InputDecoration(
                              labelText: "اسال الدكتور عن موعد الولادة",
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
                                        id: widget.appointmentsModel.id);
                                setState(() {
                                  isLoading = true;
                                });
                                bool isSuccess = await FirebaseFirestoreHelper
                                    .instance
                                    .updateAppointment(appointmentsModel);
                                if (isSuccess) {
                                  showMessage("Successfully Update");
                                  title.clear();
                                  subtitle.clear();
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                } else {
                                  showMessage("Failed");
                                }
                                isLoading = false;

                                setState(() {});
                              } else {
                                showMessage("Please Fill the details");
                              }
                            },
                            title: "تعديل",
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
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
