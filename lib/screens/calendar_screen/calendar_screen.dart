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
  bool isAdd = false;
  bool isLoading = false;

  final TextEditingController title = TextEditingController();

  final TextEditingController subtitle = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  List<AppointmentsModel> _selectedEvent = [];
  DateTime? _selectedDate;
  bool isDone = false;
  Map<DateTime, List<AppointmentsModel>> event = {};
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    _selectedDate = DateTime.utc(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _selectedEvent = _getEventsDay(_selectedDate!);
    setState(() {});
    super.initState();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDate, selectedDay)) {
      setState(() {
        _selectedDate = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvent = _getEventsDay(selectedDay);
      });
    }
  }

  List<AppointmentsModel> _getEventsDay(DateTime day) {
    return event[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getAppBar("التقويم", context),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder(
              stream: FirebaseFirestoreHelper.instance.getAppoinment(),
              builder:
                  (context, AsyncSnapshot<List<AppointmentsModel>> eventList) {
                if (!eventList.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                print(eventList.data!.length);
                if (eventList.data!.isEmpty) {
                  event={};
                  _selectedEvent = [];
                }
                // print("KAKSKAKDASKDKAS");
                for (var element in eventList.data!) {
                  print("Thanks");
                  DateTime eventDatetime = DateTime.utc(element.dateTime.year,
                      element.dateTime.month, element.dateTime.day);

                  event.addAll({
                    eventDatetime: eventList.data!
                        .where((filter) =>
                            DateTime.utc(filter.dateTime.year,
                                filter.dateTime.month, filter.dateTime.day) ==
                            eventDatetime)
                        .toList(),
                  });
                  List<AppointmentsModel> appoint = eventList.data!
                      .where((filter) =>
                          DateTime.utc(filter.dateTime.year,
                              filter.dateTime.month, filter.dateTime.day) ==
                          _selectedDate!)
                      .toList();
                  print("HELASLDKASOD===================================");
                  if (appoint.isEmpty) {
                    _selectedEvent = [];
                    event[_selectedDate!] = appoint;
                  } else {
                    event[_selectedDate!] = appoint;

                    _selectedEvent = _getEventsDay(_selectedDate!);
                  }
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      TableCalendar(
                        availableGestures: AvailableGestures.none,
                        headerStyle: const HeaderStyle(
                            formatButtonVisible: false, titleCentered: true),
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          todayDecoration: BoxDecoration(
                            color: const Color(0xffE187B0).withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: const BoxDecoration(
                            color: Color(0xffE187B0),
                            shape: BoxShape.circle,
                          ),
                        ),
                        focusedDay: _focusedDay,
                        firstDay:
                            DateTime.now().subtract(const Duration(days: 365)),
                        lastDay: DateTime.now().add(const Duration(days: 365)),
                        eventLoader: _getEventsDay,
                        calendarFormat: _calendarFormat,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        onDaySelected: _onDaySelected,
                        onFormatChanged: (format) {
                          if (_calendarFormat != format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          }
                        },
                        onPageChanged: (focusedDay) {
                          setState(() {
                            _focusedDay = focusedDay;
                          });
                        },
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDate, day),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _selectedEvent.length,
                        itemBuilder: (context, index) {
                          AppointmentsModel singleAppo = _selectedEvent[index];
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: SingleAppointmentWidget(
                              appointmentsModel: singleAppo,
                              index: index,
                              onDelete: () {
                                print("object");

                                _selectedEvent.remove(singleAppo);
                                _selectedEvent.removeAt(index);

                                setState(() {
                                  _selectedEvent.remove(singleAppo);
                                });

                                setState(() {});
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
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
                                            color: Color.fromARGB(
                                                255, 80, 13, 63)),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  205, 186, 11, 98)),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 58, 0, 28)),
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
                                      enableSuggestions: true,
                                      decoration: InputDecoration(
                                        labelText: "ملاحظات",
                                        labelStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                        floatingLabelStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 80, 13, 63)),
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  205, 186, 11, 98)),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 58, 0, 28)),
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
                                        if (title.text.isNotEmpty) {
                                          if (_focusedDay.day ==
                                              DateTime.now().day) {
                                            _focusedDay = DateTime.now();
                                          }
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
                                              await FirebaseFirestoreHelper
                                                  .instance
                                                  .addAppointment(
                                                      appointmentsModel);
                                          if (isSuccess) {
                                            showMessage(" تمت الاضافه بنجاح");
                                            title.clear();
                                            subtitle.clear();
                                            isAdd = false;
                                          } else {
                                            showMessage("فشلت عملية الاضافه");
                                          }
                                          isLoading = false;

                                          setState(() {});
                                        } else {
                                          showMessage("الرجاء تعبئة البيانات");
                                        }
                                        _selectedEvent =
                                            _getEventsDay(_selectedDate!);
                                      },
                                      title: "ادخال موعد جديد",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  PrimaryButton(
                                    onPressed: () {
                                      setState(() {
                                        title.clear();
                                        subtitle.clear();
                                        isAdd = false;
                                      });
                                    },
                                    title: "الغاء",
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              width: 250,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 18.0,
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
                                    height: 38.0,
                                  ),
                                  PrimaryButton(
                                    onPressed: () async {
                                      await Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            const MyAppointments(),
                                      ));

                                      setState(() {});
                                    },
                                    title: "مواعيدي",
                                  ),
                                ],
                              ),
                            ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                );
              }),
    );
  }
}
