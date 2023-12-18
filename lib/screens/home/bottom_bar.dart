// ignore_for_file: library_private_types_in_public_api, avoid_unnecessary_containers

import 'package:ammommyappgp/core/constants/constants.dart';
import 'package:ammommyappgp/core/constants/firebase_firestore_helper.dart';
import 'package:ammommyappgp/models/user_model.dart';
import 'package:ammommyappgp/screens/calendar_screen/calendar_screen.dart';
import 'package:ammommyappgp/screens/chat_bot/chat_bot.dart';
import 'package:ammommyappgp/screens/home/home_page.dart';
import 'package:ammommyappgp/screens/weight_control/weight_control.dart';
import 'package:collection/collection.dart'; // Import for firstWhereOrNull
import 'package:flutter/material.dart';

import '../check_list/check_list.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  void userModel() async {
    setState(() {
      isLoading = true;
    });
    UserModel getUserModel =
        await FirebaseFirestoreHelper.instance.getUserModel();
    if (mounted) {
      setState(() {
        userData = getUserModel;
        if (userData!.dueDate != null) {
          DateTime initialDate = userData!.dueDate!;

          // Add 280 days to the initial date
          DateTime futureDate = initialDate.add(const Duration(days: 280));
          Duration difference = futureDate.difference(DateTime.now());
          int substractWeeks = (difference.inDays / 7).ceil();
          setState(() {
            remainWeeks = 40 - substractWeeks;
            remainDays = difference.inDays;
            if (weeklyInfo.isNotEmpty) {
              currentWeeklyInfo = weeklyInfo
                  .firstWhereOrNull((element) => element.week == remainWeeks.toString());
            } else {
              currentWeeklyInfo = null;
            }
          });
        }
        isLoading = false;
      });
    }
  }

  bool isLoading = false;

  @override
  void initState() {
    userModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PageStorage(
              bucket: bucket,
              child: currentScreen,
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Image.asset("assets/robot.png"),
        onPressed: () {
          setState(() {
            currentScreen = const ChatBot();
            currentTab = 9;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            const HomePage(); // if the user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Icon(
                      Icons.home_sharp,
                      size: 35,
                      color: currentTab == 0
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const CalendarScreen();
                        currentTab = 1;
                      });
                    },
                    child: Icon(
                      Icons.calendar_month_outlined,
                      size: 35,
                      color: currentTab == 1
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const WeightControl();
                        currentTab = 2;
                      });
                    },
                    child: Icon(
                      Icons.av_timer,
                      size: 35,
                      color: currentTab == 2
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            const CheckList(); // if the user taps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Icon(
                      Icons.checklist,
                      size: 35,
                      color: currentTab == 3
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
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
