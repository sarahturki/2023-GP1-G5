import 'package:ammommyappgp/core/constants/firebase_auth_helper.dart';
import 'package:ammommyappgp/screens/article_screen/article_screen.dart';
import 'package:ammommyappgp/screens/frequently_asked_questions/frequently_asked_questions.dart';
import 'package:ammommyappgp/screens/hospital_bag/hospital-bag.dart';
import 'package:ammommyappgp/screens/to_do_list/to_do_list.dart';
import 'package:ammommyappgp/screens/vital_information_view/vital_information_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../../models/user_model.dart';
import '../../widgets/primary_button.dart';
import '../baby_names/baby_names.dart';
import '../home/home_page.dart';
import '../profile_screen/profile_screen.dart';
import '../welcome_screen/welcome_screen.dart';

int selectedWeekOfDetails = 0;

class CheckList extends StatefulWidget {
  const CheckList({super.key});

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {

  @override
  void initState() {
   setState(() {
     selectedWeekOfDetails=remainWeeks!;
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: FirebaseFirestore.instance
            .collection("user")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots()
            .map((event) => UserModel.fromJson(event.data()!)),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            endDrawer: customDraver(context, snapshot.data!),
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0.0,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                "${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 36),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                textAlign: TextAlign.center,
                                "أنتي في الأسبوع  ${arabicNumber[remainWeeks! - 1]}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Transform.translate(
                      offset: const Offset(0, 0),
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                          itemCount: 40,
                          shrinkWrap: true,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            int indexCount = index + 1;

                            return GestureDetector(
                              onTap: () {
                                currentWeeklyInfo = weeklyInfo
                                    .where((element) =>
                                        element.week == indexCount.toString())
                                    .first;

                                setState(() {
                                  selectedWeekOfDetails = indexCount;
                                });
                              },
                              child: dateCustom(
                                title: "الأسبوع",
                                subtitle: arabicNumber[index].toString(),
                                textColor: indexCount == remainWeeks
                                    ? Colors.white
                                    : Colors.black,
                                isSelected: indexCount != remainWeeks &&
                                    selectedWeekOfDetails == indexCount,
                                color: indexCount == remainWeeks
                                    ? const Color(0xffD66095)
                                    : Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleItemOfCheckList(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HospitalBag(),
                          ));
                        },
                        title: "حقيبة المستشفى",
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SingleItemOfCheckList(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ToDoList(),
                          ));
                        },
                        title: "قائمة المهام",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleItemOfCheckList(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BabyNames(),
                          ));
                        },
                        title: "قائمة أسماء\n الطفل ",
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SingleItemOfCheckList(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const VitalInformationView(),
                          ));
                        },
                        title: "المعلومات الحيويه",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleItemOfCheckList(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ArticleScreen(
                                remainWeeks: selectedWeekOfDetails),
                          ));
                        },
                        title: "المقالات",
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SingleItemOfCheckList(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FrequentlyAskedQuestions(
                                remainWeeks: selectedWeekOfDetails),
                          ));
                        },
                        title: "الأسئلة الشائعة",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget customDraver(context, UserModel newMo) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, right: 5),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${newMo.firstName} ${newMo.lastName}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            newMo.email,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img_group56.png'),
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/img_logoremovebgpreview_293x252.png'),
                                fit: BoxFit.contain))),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ));
                    setState(() {});
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                      Text(
                        "تعديل الملف الشخصي",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.person,
                        size: 30,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: PrimaryButton(
              onPressed: () async {
                await FirebaseAuthHelper.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                    (route) => false);
                setState(() async {
                                          await Future.delayed(const Duration(seconds:2 ));

                  currentWeeklyInfo = null;
                  selectedWeekOfDetails = 0;
                });
                showMessage("تم تسجيل الخروج بنجاح");
              },
              title: "تسجيل الخروج",
            ),
          ),
        ],
      ),
    );
  }
}

class SingleItemOfCheckList extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const SingleItemOfCheckList(
      {super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 190,
        width: 180,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusStyle.roundedBorder28,
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              ColorConstant.pinkA100Ba,
              ColorConstant.red50,
            ],
          ),
        ),
        child: Center(
            child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
        )),
      ),
    );
  }
}
